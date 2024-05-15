
set -e

if [ -n "$IS_CI" ]; then
    node -v
    npm -v
    if [ ! -x "$(command -v pnpm)" ]; then
        npm install -g pnpm
    fi
    pnpm install
    pnpm -v
fi

WORKDIR=$(cd $(dirname $0); cd ..; pwd)
HTML_MINIFY=$WORKDIR/scripts/html_minify.js

# build docs
cd $WORKDIR/pages/docs
if [ ! -d "./dist" ]; then
    mkdir dist
fi
node $HTML_MINIFY index.html ./dist/index.html

# build landing
cd $WORKDIR/pages/landing
if [ ! -d "./dist" ]; then
    mkdir dist
fi
node $HTML_MINIFY index.html ./dist/index.html
cp og-image.jpg ./dist/og-image.jpg
cp twitter-card-image.jpg ./dist/twitter-card-image.jpg

echo "Build done!"
