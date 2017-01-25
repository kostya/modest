require "../src/modest"

page = <<-PAGE
  <html>
    <div class=aaa><p id=bbb><a href="http://..." class=ccc>bla</a></div>
  </html>
PAGE

myhtml = Myhtml::Parser.new(page)

# css select from the root! scope
iterator = myhtml.css("div.aaa p#bbb a.ccc") # => Iterator(Myhtml::Node), methods: .each, .to_a, ...

iterator.each do |node|
  p node.tag_id              # MyHTML_TAG_A
  p node.tag_name            # "a"
  p node.tag_sym             # :a
  p node.attributes["href"]? # => "http://..."
  p node.inner_text          # "bla"
  puts node.to_html          # <a href="http://..." class="ccc">bla</a>
end

# css select from node scope
if p_node = myhtml.css("div.aaa p#bbb").first?
  p_node.css("a.ccc").each do |node|
    p node.tag_sym # :a
  end
end
