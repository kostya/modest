require "modest"

page = File.read("./google.html")

s = 0
links = [] of String
myhtml = Myhtml::Parser.new(page)
1000.times do
  links = myhtml.css("div.g h3.r a").map(&.attribute_by("href")).to_a
  s += links.size
end
p s
