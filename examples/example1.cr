require "../src/modest"

page = <<-PAGE
  <html>
    <div class=aaa><p id=bbb><a href="http://..." class=ccc>bla</a></p></div>
  </html>
PAGE

myhtml = Myhtml::Parser.new("<html>...</html>")

# css select from the root! scope
iterator = myhtml.css("div.aaa p#bbb a.ccc") # => Iterator(Myhtml::Node), methods: .each, .to_a, ...

iterator.each do |node|
  p node.tag_id
  p node.tag_name            # "a"
  p node.tag_sym             # :a
  p node.attributes["href"]? # => "http://..."
  p node.inner_text          # "bla"
  p node.to_html             #
end
