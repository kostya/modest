require "./src/modest"

html = <<-HTML
  <div>
    <p id=p1>
    <p id=p2 class=jo>
    <p id=p3>
      <a>link</a>
    <div id=bla>
      <p id=p4 class=jo>
      <p id=p5 class=bu>
      <p id=p6 class=jo>
    </div>
  </div>
HTML

parser = Myhtml::Parser.new.parse(html)

# select all nodes with class "jo"
p parser.css(".jo").map(&.attribute_by("id")).to_a # => ["p2", "p4", "p6"]

# select odd child tag inside div, which not contain a
p parser.css("div > :nth-child(2n+1):not(:has(a))").map(&.attribute_by("id")).to_a # => ["p1", "p4", "p6"]

# all elements with class=jo inside last div tag
p parser.nodes(:div).to_a.last.css(".jo").map(&.attribute_by("id")).to_a # => ["p4", "p6"]
