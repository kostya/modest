# modest

CSS selectors for HTML5 Parser [myhtml](https://github.com/kostya/myhtml) (Crystal wrapper for https://github.com/lexborisov/Modest).

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  modest:
    github: kostya/modest
```

## Usage of CSS Selectors with myhtml parser

```crystal
require "modest"

page = <<-PAGE
  <html>
    <div class=aaa><p id=bbb><a href="http://..." class=ccc>bla</a></div>
  </html>
PAGE

myhtml = Myhtml::Parser.new(page)

# css select from the root! scope (equal with myhtml.root!.css("..."))
iterator = myhtml.css("div.aaa p#bbb a.ccc") # => Iterator(Myhtml::Node), methods: .each, .to_a, ...

iterator.each do |node|
  p node.tag_id              # MyHTML_TAG_A
  p node.tag_name            # "a"
  p node.tag_sym             # :a
  p node.attributes["href"]? # "http://..."
  p node.inner_text          # "bla"
  puts node.to_html          # <a href="http://..." class="ccc">bla</a>
end

# css select from node scope
if p_node = myhtml.css("div.aaa p#bbb").first?
  p_node.css("a.ccc").each do |node|
    p node.tag_sym # :a
  end
end

```

## Example 2

```crystal
require "modest"

html = <<-PAGE
  <div>
    <p id=p1>
    <p id=p2 class=jo>
    <p id=p3>
      <a href="some.html" id=a1>link1</a>
      <a href="some.png" id=a2>link2</a>
    <div id=bla>
      <p id=p4 class=jo>
      <p id=p5 class=bu>
      <p id=p6 class=jo>
    </div>
  </div>
PAGE

parser = Myhtml::Parser.new(html)

# select all p nodes which id like `*p*`
p parser.css("p[id*=p]").map(&.attribute_by("id")).to_a # => ["p1", "p2", "p3", "p4", "p5", "p6"]

# select all nodes with class "jo"
p parser.css("p.jo").map(&.attribute_by("id")).to_a # => ["p2", "p4", "p6"]
p parser.css(".jo").map(&.attribute_by("id")).to_a # => ["p2", "p4", "p6"]

# select odd child tag inside div, which not contain a
p parser.css("div > :nth-child(2n+1):not(:has(a))").map(&.attribute_by("id")).to_a # => ["p1", "p4", "p6"]

# all elements with class=jo inside last div tag
p parser.css("div").to_a.last.css(".jo").map(&.attribute_by("id")).to_a # => ["p4", "p6"]

# a element with href ends like .png
p parser.css(%q{a[href$=".png"]}).map(&.attribute_by("id")).to_a # => ["a2"]

# find all a tags inside <p id=p3>, which href contain `html`
p parser.css(%q{p[id=p3] > a[href*="html"]}).map(&.attribute_by("id")).to_a # => ["a1"]

# find all a tags inside <p id=p3>, which href contain `html` or ends_with `.png`
p parser.css(%q{p[id=p3] > a:matches([href *= "html"], [href $= ".png"])}).map(&.attribute_by("id")).to_a # => ["a1", "a2"]

# create finder and use it in many places, this is faster, than create it many times
finder = Modest::Finder.new(".jo")
p parser.css(finder).map(&.attribute_by("id")).to_a # => ["p2", "p4", "p6"]
```

## Example 3
```crystal
require "modest"

html = <<-PAGE
  <html><body>
  <table id="t1"><tbody>
  <tr><td>Hello</td></tr>
  </tbody></table>
  <table id="t2"><tbody>
  <tr><td>123</td><td>other</td></tr>
  <tr><td>foo</td><td>columns</td></tr>
  <tr><td>bar</td><td>are</td></tr>
  <tr><td>xyz</td><td>ignored</td></tr>
  </tbody></table>
  </body></html>
PAGE

parser = Myhtml::Parser.new(html)

p parser.css("#t2 tr td:first-child").map(&.inner_text).to_a # => ["123", "foo", "bar", "xyz"]
p parser.css("#t2 tr td:first-child").map(&.to_html).to_a # => ["<td>123</td>", "<td>foo</td>", "<td>bar</td>", "<td>xyz</td>"]
```

## Benchmark

Comparing with nokorigi(libxml), and crystagiri(libxml). Parse 1000 times google page, code: https://github.com/kostya/modest/tree/master/bench

```crystal
require "modest"
page = File.read("./google.html")
s = 0
links = [] of String
1000.times do
  myhtml = Myhtml::Parser.new(page)
  links = myhtml.css("div.g h3.r a").map(&.attribute_by("href")).to_a
  s += links.size
  myhtml.free
end
p links.last
p s
```

Parse + Selectors

| Lang     |  Package           | Time, s | Memory, MiB |
| -------- | ------------------ | ------- | ----------- |
| Crystal  | modest(myhtml)     | 2.52    | 7.7         |
| Crystal  | Crystagiri(LibXML) | 19.89   | 14.3        |
| Ruby 2.2 | Nokogiri(LibXML)   | 45.05   | 136.2       |

Selectors Only (files with suffix 2)

| Lang     |  Package           | Time, s | Memory, MiB |
| -------- | ------------------ | ------- | ----------- |
| Crystal  | modest(myhtml)     | 0.18    | 4.6         |
| Crystal  | Crystagiri(LibXML) | 12.30   | 6.6         |
| Ruby 2.2 | Nokogiri(LibXML)   | 28.06   | 68.8        |


## CSS Selectors rules
https://drafts.csswg.org/selectors-4/
