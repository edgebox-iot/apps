# A script to bootstrap a new app from an available template

# Default template is "hello"
# This script should ask for the following:
# - app_slug
# - app_name
# - app_description
# - contains_options

# The script should then:
# - Copy the template folder ./hello to ./../$app_slug
# - In the new folder, do the following:
#   - If contains_options is false (default yes), delete the edgapp.template.env file
#   - Replace all instances of exactly "hello" (case sensitive) with $app_slug in all files
#   - Replace all instances of exactly "Hello World" (case sentitive) with $app_name in all files
#   - Replace all instances of excatly "EdgeApp Template" (case sensitive) with $app_description in all files

echo "📦 Preparing to bootstrap new app from template"

template="hello"
contains_options="no"

# Make sure directory where this runs is the directory where the templates are located
cd "$(dirname "$0")"
cd ../.templates/

# Read argument $1 as template, if not provided, ask for it
if [ -z "$1" ]; then
  echo "🟡 Using default template to bootstrap a new app."
else
  echo "🟢 Using $1 template to bootstrap a new app."
  template=$1
fi

# Check if folder named $template exists, if not exit
if [ ! -d "./$template" ]; then
  echo "🔴 Template $template not found"
  exit 1
fi

# Read app_slug, app_name, app_description from $template/edgebox.env
if [ -f "./$template/edgebox.env" ]; then
  template_app_slug=$(grep "COMPOSE_APP_SLUG" "./$template/edgebox.env" | cut -d'=' -f2)
  template_app_name=$(grep "EDGEAPP_NAME" "./$template/edgebox.env" | cut -d'=' -f2)
  template_app_description=$(grep "EDGEAPP_DESCRIPTION" "./$template/edgebox.env" | cut -d'=' -f2)
fi

# Attempt to load arguments 2, 3 and 4 as app_slug, app_name and app_description
if [ -n "$2" ]; then
  app_slug=$2
fi

if [ -n "$3" ]; then
  app_name=$3
fi

if [ -n "$4" ]; then
  app_description=$4
fi

if [ -n "$5" ]; then
  contains_options=$5
fi

# If any of the values are not set, ask for them

if [ -z "$app_slug" ]; then
  # Ask for app_slug
  read -p "Enter app slug (default: $template_app_slug): " input
  app_slug=${input:-$template_app_slug}
fi


# Ask for app_name if not set
if [ -z "$app_name" ]; then
  read -p "Enter app name (default: $template_app_name): " input
  app_name=${input:-$template_app_name}
fi

# Ask for app_description if not set
if [ -z "$app_description" ]; then
  read -p "Enter app description (default: $template_app_description): " input
  app_description=${input:-$template_app_description}
fi

# Ask for contains_options if not set
if [ -z "$contains_options" ]; then
  read -p "Does the app contain options? (default: $contains_options): " input
  contains_options=${input:-$contains_options}
fi

# If the target folder already exists, ask for confirmation to overwrite
if [ -d "./../$app_slug" ]; then
  read -p "🟡 App $app_slug already exists in the system. Do you want to overwrite it? (yes/no): " input
  if [ "$input" != "yes" ]; then
    echo "🔴 Exiting..."
    exit 1
  fi
  rm -rf "./../$app_slug"
fi

# Copy the template folder ./hello to ./../$app_slug
cp -r "./$template" "./../$app_slug"
# In the new folder, do the replacements
cd "./../$app_slug"
if [ "$contains_options" == "no" ]; then
  rm -f "./edgeapp.template.env"
fi

echo "🚀 Bootstrapping $app_slug"

# Replace all instances of exactly "hello" (case sensitive) with $app_slug in all text files
find . -type f -exec grep -Iq . {} \; -and -exec sed -i '' "s/$template_app_slug/$app_slug/g" {} +

# Replace all instances of exactly "Hello World" (case sensitive) with $app_name in all text files
find . -type f -exec grep -Iq . {} \; -and -exec sed -i '' "s/$template_app_name/$app_name/g" {} +

# Replace all instances of exactly "EdgeApp Template" (case sensitive) with $app_description in all text files
find . -type f -exec grep -Iq . {} \; -and -exec sed -i '' "s/$template_app_description/$app_description/g" {} +

echo "🟢 Bootstrap complete."