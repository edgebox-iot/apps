use log::{error, warn};
use ruma::{
    api::client::{
        error::{Error as RumaError, ErrorKind},
        r0::uiaa::UiaaInfo,
    },
    ServerName,
};
use thiserror::Error;

#[cfg(feature = "conduit_bin")]
use {
    crate::RumaResponse,
    http::StatusCode,
    rocket::{
        response::{self, Responder},
        Request,
    },
    ruma::api::client::r0::uiaa::UiaaResponse,
};

pub type Result<T> = std::result::Result<T, Error>;

#[derive(Error, Debug)]
pub enum Error {
    #[cfg(feature = "sled")]
    #[error("There was a problem with the connection to the sled database.")]
    SledError {
        #[from]
        source: sled::Error,
    },
    #[cfg(feature = "rocksdb")]
    #[error("There was a problem with the connection to the rocksdb database: {source}")]
    RocksDbError {
        #[from]
        source: rocksdb::Error,
    },
    #[error("Could not generate an image.")]
    ImageError {
        #[from]
        source: image::error::ImageError,
    },
    #[error("Could not connect to server: {source}")]
    ReqwestError {
        #[from]
        source: reqwest::Error,
    },
    #[error("{0}")]
    FederationError(Box<ServerName>, RumaError),
    #[error("Could not do this io: {source}")]
    IoError {
        #[from]
        source: std::io::Error,
    },
    #[error("{0}")]
    BadServerResponse(&'static str),
    #[error("{0}")]
    BadConfig(&'static str),
    #[error("{0}")]
    /// Don't create this directly. Use Error::bad_database instead.
    BadDatabase(&'static str),
    #[error("uiaa")]
    Uiaa(UiaaInfo),

    #[error("{0}: {1}")]
    BadRequest(ErrorKind, &'static str),
    #[error("{0}")]
    Conflict(&'static str), // This is only needed for when a room alias already exists
}

impl Error {
    pub fn bad_database(message: &'static str) -> Self {
        error!("BadDatabase: {}", message);
        Self::BadDatabase(message)
    }

    pub fn bad_config(message: &'static str) -> Self {
        error!("BadConfig: {}", message);
        Self::BadConfig(message)
    }
}

#[cfg(feature = "conduit_bin")]
impl<'r, 'o> Responder<'r, 'o> for Error
where
    'o: 'r,
{
    fn respond_to(self, r: &'r Request<'_>) -> response::Result<'o> {
        if let Self::Uiaa(uiaainfo) = self {
            return RumaResponse::from(UiaaResponse::AuthResponse(uiaainfo)).respond_to(r);
        }

        if let Self::FederationError(origin, mut error) = self {
            error.message = format!("Answer from {}: {}", origin, error.message);
            return RumaResponse::from(error).respond_to(r);
        }

        let message = format!("{}", self);

        use ErrorKind::*;
        let (kind, status_code) = match self {
            Self::BadRequest(kind, _) => (
                kind.clone(),
                match kind {
                    Forbidden | GuestAccessForbidden | ThreepidAuthFailed | ThreepidDenied => {
                        StatusCode::FORBIDDEN
                    }
                    Unauthorized | UnknownToken { .. } | MissingToken => StatusCode::UNAUTHORIZED,
                    NotFound => StatusCode::NOT_FOUND,
                    LimitExceeded { .. } => StatusCode::TOO_MANY_REQUESTS,
                    UserDeactivated => StatusCode::FORBIDDEN,
                    TooLarge => StatusCode::PAYLOAD_TOO_LARGE,
                    _ => StatusCode::BAD_REQUEST,
                },
            ),
            Self::Conflict(_) => (Unknown, StatusCode::CONFLICT),
            _ => (Unknown, StatusCode::INTERNAL_SERVER_ERROR),
        };

        warn!("{}: {}", status_code, message);

        RumaResponse::from(RumaError {
            kind,
            message,
            status_code,
        })
        .respond_to(r)
    }
}
