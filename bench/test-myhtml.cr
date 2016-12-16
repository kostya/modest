require "modest"

page = File.read("./google.html")

s = 0
links = [] of String
1000.times do
  myhtml = Myhtml::Parser.new(page)
  links = myhtml.css("div.g > div.rc > h3.r a").map(&.attribute_by("href")).to_a
  s += links.size
  myhtml.free
end
p links.last
p s
