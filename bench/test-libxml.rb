require "bundler/setup"
require "nokogiri"

page = File.read("./google.html")

s = 0
links = []
1000.times do
  doc = Nokogiri::HTML(page)
  links = doc.css("div.g h3.r a").map { |link| link["href"] }
  s += links.size
end
p links.last
p s
