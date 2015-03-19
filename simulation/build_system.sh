node_modules/.bin/browserify \
    -t coffeeify \
        --extension=".coffee" \
    src/app.coffee > bin/app.js


cp src/index.html bin

cp bower_components/jquery/dist/jquery.min.js bin
cp bower_components/smoothie/smoothie.js bin


node bin/app.js
