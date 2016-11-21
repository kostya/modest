require "./spec_helper"

describe Modest do
  it "selectors work" do
    html = "<div><p id=p1><p id=p2><p id=p3><a>link</a><p id=p4><p id=p5><p id=p6></div>"
    selector = "div > :nth-child(2n+1):not(:has(a))"

    parser = Myhtml::Parser.new.parse(html)
    finder = Modest::Finder.new(parser.tree, selector)
    nodes = finder.find(parser.html!)

    p nodes.size
  end
end
