#!/bin/sh

RUST_LOG="walrus=error"

echo Compiling
cargo build --target=wasm32-unknown-unknown

echo Bindgen
wasm-bindgen --target=web --out-dir=./target/wasm-bindgen/debug ./target/wasm32-unknown-unknown/debug/yew_front.wasm --no-typescript

if ! [ -d "out" ]; then
    echo Creating ouput directory
    mkdir out
else
    echo Updating ouput directory
fi

cp ./target/wasm-bindgen/debug/* ./out 

cat << EOF >> ./out/index.html
<!DOCTYPE html><html lang='en'>
<head>
  <meta charset='utf-8'>
  <title>Yew • Counter</title>

  <script type='module'>
    import init from './yew_front.js';
    init('yew_front_bg.wasm');
  </script>
  
  <!--   <link rel='preload' href='./yew_front_bg.wasm' as='fetch' type='application/wasm' crossorigin=''>
    <link rel='modulepreload' href='./yew_front.js'> -->
</head>
  <body>
  </body>
</html>
EOF
echo Everything should be ready in ./out

echo Python demo server at http://localhost:8000/out
python -m http.server > /dev/null