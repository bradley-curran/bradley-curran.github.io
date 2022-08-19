# `bssg` - Brad's Static Site Generator

My personal website has gone through a number of iterations over the years. 
Most of the time it has been a static landing page showing some projects I've worked on and some contact details. Nothing too fancy. 

In the past I've used GitHub Pages with the static site generator Jekyll for my site. 
While Jekyll is useful, it's very prescriptive in the way it wants you to store files. 

With yet another iteration of my site, I decided to create my own static site generator, rather than using an existing tool.
`bssg` is yet another static site generator.  

![Standards](https://imgs.xkcd.com/comics/standards.png)

## What's a static site generator?

You can think of a static site generator as a type of build tool, specifically for generating static websites.

Static websites are very simple. They're just a bunch of HTML files stored on a server. 

Now, you *could* create an entire website by writing HTML manually. That quickly becomes a pain. Changing your website log means changing every page that has the website logo in it. 

Instead, you can write your website in a format that's easy to write, then use a static website generator to convert that into HTML. You can also do things like have your logo in one file and reuse that file everywhere else. To change your logo, just change that file and every page on your website will update automatically! 

## Using `bssg`

Install `bssg` using `npm`: 

```bash
npm install -g bssg
```

`bssg` follows a list of build steps defined in a `bssg.toml` file. 
Each build step has a `step` key to identify the step type. 
It also has a number of other keys, depending on the `step` type. 

### `bssg.toml` Example

```toml
[bssg]

[[build.steps]]
step = "rm"
path = "docs"

[[build.steps]]
step = "mkdir"
path = "docs"

[[build.steps]]
step = "cp"
inputFile = "CNAME"
outputFile = "docs/CNAME"

[[build.steps]]
step = "transformless"
inputFile = "style.less"
outputFile = "docs/style.less"

[[build.steps]]
step = "transformpug",
inputFile = "pug/index.pug",
outputFile = "docs/index.html"
```
