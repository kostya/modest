# modest

Crystal wrapper for lexborisov/Modest. CSS selectors for HTML5 Parser Myhtml.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  modest:
    github: kostya/modest
```


## Usage of CSS Selectors inside with kostya/myhtml


```crystal
require "modest"

html = "<div><p id=p1><p id=p2><p id=p3><a>link</a>
  <span id=bla><p id=p4 class=jo><p id=p5 class=bu><p id=p6 class=jo></span></div>"
parser = Myhtml::Parser.new.parse(html)

# select all nodes with class "jo"
p parser.root!.css(".jo").map(&.attribute_by("id")).to_a # => ["p4", "p6"]

# select odd p tag inside div, which not contain a
p parser.css("div > :nth-child(2n+1):not(:has(a))").map(&.attribute_by("id")).to_a # => ["p1", "p5"]

```

## CSS Selectors rules
http://www.w3schools.com/cssref/css_selectors.asp
