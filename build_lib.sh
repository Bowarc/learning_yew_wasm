#!/bin/sh
set -e

RUST_LOG="walrus=error"

mode=release # debug, release

echo Compiling + Bindgen
if [ "$mode" = release ]
then
  wasm-pack build --release --target web --no-typescript
else
  wasm-pack build --target web --no-typescript
fi


echo Updating ouput directory

cat << EOF > ./pkg/index.html
<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='utf-8'>
    <title>Yew • Counter</title>
    <link rel="stylesheet" type="text/css" href="./style.css">
    <script type='module'>
      import init from './yew_wasm.js';
      init('yew_wasm_bg.wasm');
    </script>
    
    <!--   <link rel='preload' href='./yew_wasm_bg.wasm' as='fetch' type='application/wasm' crossorigin=''>
      <link rel='modulepreload' href='./yew_wasm.js'> -->
  </head>
  <body>
  </body>
</html>
EOF

cat << EOF > ./pkg/style.css
button {
  background-color: #008f53; /* Green */
  border: 0;
  color: white;
  padding: 14px 14px;
  text-align: center;
  font-size: 16px;
  margin: 2px 2px;
  width: 100px;
}

.counter {
  color: #008f53;
  font-size: 48px;
  text-align: center;
}

.footer {
  text-align: center;
  font-size: 12px;
}

.panel {
  display: flex;
  justify-content: center;
}
EOF

echo Everything should be ready in ./pkg

echo Python demo server at http://localhost:8000/pkg
python -m http.server > /dev/null