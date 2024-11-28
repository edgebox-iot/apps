# mkdir -p ./appdata/syncthing-ws
echo "📦 syncthing postinstall script"
echo "- Running in $(pwd)"
echo "- Copying files to ./appdata/syncthing-ws"
cp ./src/install/* ./appdata/syncthing-ws/