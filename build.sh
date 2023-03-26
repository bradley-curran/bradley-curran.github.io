#!/bin/sh

set -e # exit when any command fails
set -v # echo commands

# start from scratch each time
rm -rf docs
mkdir docs

# config
cp CNAME docs/CNAME

# style
bssg lessc style.less > docs/style.css

# top-level pages
bssg pugc pug/index.pug data.json > docs/index.html
bssg pugc pug/rss.pug data.json > docs/rss.xml

# blog
mkdir docs/blog
bssg markdownc blog/bssg.md pug/blog.pug > docs/blog/bssg.html
bssg markdownc blog/from-docker-to-nerdctl.md pug/blog.pug > docs/blog/from-docker-to-nerdctl.html
