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

`bssg` exposes a number of useful functions as a single command-line executable. 

The output of each function goes to stdout by default. You can redirect the output using the `>` operator. 

You can execute `bssg` with no arguments to get the list of supported functions: 

```
Usage: bssg [options] [command]

Brad's Static Website Generator

Options:
  -V, --version                          output the version number
  -h, --help                             display help for command

Commands:
  lessc <input-file>                     compile a less file
  markdownc <input-file> [extends-file]  compile a markdown file
  pugc <input-file> [locals-file]        compile a pug file
  help [command]                         display help for command
```

### `lessc`

Compiles a `.less` file into CSS. 

```bash
# reads a less file, converts it to CSS, and writes it to style.css
bssg lessc style.less > style.css
```

### `markdownc`

Compiles a markdown file into HTML

```bash
# reads a markdown file, converts it to HTML, and writes it to blog.html
bssg markdownc blog.md > blog.html

# reads a markdown file, converts it to HTML, 
# compiles a pug file, injects the compiled markdown into it,
# and (finally) writes it to blog.html 
# replaces BLOCK_CONTENT in the pug file
bssg markdownc blog.md blog.pug > blog.html 
```

### `pugc`

Compiles a pug file into HTML

```bash
# reads a pug file, converts it to HTML and writes it to index.html
bssg pugc index.pug > index.html

# reads a pug file, using a JSON file as the locals,
# and writes it to index.html
bssg pugc index.pug locals.json > index.html
```
