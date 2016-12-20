require "modest"

page = File.read("./google.html")

s = 0
links = [] of String
myhtml = Myhtml::Parser.new(page)
selector = Myhtml::Parser.finder("div.g h3.r a") # create a selector need some time
1000.times do
  links = myhtml.css(selector).map(&.attribute_by("href")).to_a
  s += links.size
end
p s
