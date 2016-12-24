require "./src/modest"

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

# sub cssing
parser.css("#t2 tr").each do |node|
  p node.css("td:first-child").first.inner_text
end
