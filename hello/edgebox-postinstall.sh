# mkdir -p ./appdata/hello-ws
echo "📦 Hello World postinstall script"
echo "- Running in $(pwd)"
echo "- Copying files to ./appdata/hello-ws"
cp ./src/install/* ./appdata/hello-ws/