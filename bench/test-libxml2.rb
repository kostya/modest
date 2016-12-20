require "bundler/setup"
require "nokogiri"

page = File.read("./google.html")

s = 0
doc = Nokogiri::HTML(page)
1000.times do
  links = doc.css("div.g h3.r a").map { |link| link["href"] }
  s += links.size
end
p s
