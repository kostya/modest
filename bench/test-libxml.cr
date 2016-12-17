require "crystagiri"

page = File.read("./google.html")

s = 0
links = Array(String).new(initial_capacity: 100)
1000.times do
  links.clear
  doc = Crystagiri::HTML.new page
  doc.css("div.g h3.r a") { |tag| links << tag.node["href"].not_nil! }
  s += links.size
end
p links.last
p s
