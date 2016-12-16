require "crystagiri"

page = File.read("./google.html")

record Link, href : String, title : String, description : String

def parse(page)
  links = Array(Link).new(initial_capacity: 100)
  doc = Crystagiri::HTML.new page
  doc.css("div.g > div.rc > h3.r a") { |tag| links << tag.node["href"].not_nil! }
end

s = 0
t = Time.now
1000.times do
  parse(page)
end
p s
p Time.now - t
