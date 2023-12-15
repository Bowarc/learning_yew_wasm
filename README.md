## Introduction
Hi

I wanted to learn wasm because i don't like doing front-end with js/ts.

My goal was to be able to make a wasm front-end that i could serve with any webserver
(just like you would with simple js).

That is why i diddn't want [trunk](https://github.com/trunk-rs/trunk) to be the final solution.

I chose [yew](https://github.com/yewstack/yew) as my front-end framework.

This tutorial will be on how to run [this yew counter example](https://github.com/yewstack/yew/tree/master/examples/counter) with a demo python webserver (`python -m http.server`).

## Tools
I will only use cargo,  [wasm-bindgen](https://github.com/rustwasm/wasm-bindgen) (0.2.89 latest for me) 
```sh
cargo install --locked wasm-bindgen-cli
```
and Python 3.12.0 (tho any python being able to run a simple http server will do the job)

## Problems
Every docs i could find would else be doing really simple stuff like adding numbers
or using trunk to compile and serve their application
which is already cool but not what i want.

I tried using [wasm-pack](https://github.com/rustwasm/wasm-pack) which requires the project to be a lib to then be manually called by you in the js but could not find a way to execute my yew app with it (probably just some sort of export mistake on my part).

Then i tried using [trunk](https://github.com/trunk-rs/trunk) as the example suggested to have a better idea on how wasm worked.  
As expected, it worked.  
But using [trunk](https://github.com/trunk-rs/trunk) to serve isn't what i want.

I couldn't find a way to make it work with the python webserver as trunk uses trunk-specific tags in it's html 
```html
<link data-trunk rel="rust" />
<link data-trunk rel="sass" href="index.scss" />
```

I then found that with some small modification i was able to run what [trunk](https://github.com/trunk-rs/trunk) had built with a demo python server (`python -m http.server`)

After that, when looking at how [trunk](https://github.com/trunk-rs/trunk) worked i saw that it was just a wrapper arround [wasm-bindgen](https://github.com/rustwasm/wasm-bindgen).

## Solution
Compile with cargo, execute [wasm-bindgen](https://github.com/rustwasm/wasm-bindgen) to create the js file, write a simple html and there was it my yew front end was able to be served by any webserver !


## How to use
Clone this repo  
Compile and serve with python webserver using 
```sh
sh build.sh
```

To use with any other webserver, just take the content of the `./out` directory and serve it as you would with normal html/js


## TLDR
Check [build.sh](build.sh)