require "./spec_helper"

describe Modest do
  it "direct use Finder" do
    html = "<div><p id=p1><p id=p2><p id=p3><a>link</a><p id=p4><p id=p5><p id=p6></div>"
    selector = "div > :nth-child(2n+1):not(:has(a))"

    parser = Myhtml::Parser.new.parse(html)
    finder = Modest::Finder.new(selector)
    nodes = finder.find(parser.html!).to_a

    nodes.size.should eq 2

    n1, n2 = nodes

    n1.tag_name.should eq "p"
    n1.attribute_by("id").should eq "p1"

    n2.tag_name.should eq "p"
    n2.attribute_by("id").should eq "p5"
  end

  it "css for root! node" do
    html = "<div><p id=p1><p id=p2 class=jo><p id=p3><a>link</a><span id=bla><p id=p4 class=jo><p id=p5 class=bu><p id=p6 class=jo></span></div>"

    parser = Myhtml::Parser.new.parse(html)
    nodes = parser.root!.css("div > :nth-child(2n+1):not(:has(a))").to_a

    nodes.size.should eq 2

    n1, n2 = nodes

    n1.tag_name.should eq "p"
    n1.attribute_by("id").should eq "p1"

    n2.tag_name.should eq "p"
    n2.attribute_by("id").should eq "p5"
  end

  it "another rule" do
    html = "<div><p id=p1><p id=p2 class=jo><p id=p3><a>link</a><span id=bla><p id=p4 class=jo><p id=p5 class=bu><p id=p6 class=jo></span></div>"

    parser = Myhtml::Parser.new.parse(html)
    parser.root!.css(".jo").to_a.map(&.attribute_by("id")).should eq %w(p2 p4 p6)
  end

  it "another rule for parser itself" do
    html = "<div><p id=p1><p id=p2 class=jo><p id=p3><a>link</a><span id=bla><p id=p4 class=jo><p id=p5 class=bu><p id=p6 class=jo></span></div>"

    parser = Myhtml::Parser.new.parse(html)
    parser.css(".jo").to_a.map(&.attribute_by("id")).should eq %w(p2 p4 p6)
  end

  it "work for another scope node" do
    html = "<div><p id=p1><p id=p2 class=jo><p id=p3><a>link</a><div id=bla><p id=p4 class=jo><p id=p5 class=bu><p id=p6 class=jo></div></div>"

    parser = Myhtml::Parser.new.parse(html)
    parser.nodes(:div).to_a.last.css(".jo").to_a.map(&.attribute_by("id")).should eq %w(p4 p6)
    parser.nodes(:div).to_a.first.css(".jo").to_a.map(&.attribute_by("id")).should eq %w(p2 p4 p6)
  end

  context "build finder" do
    it "for parser" do
      html = "<div><p id=p1><p id=p2 class=jo><p id=p3><a>link</a><span id=bla><p id=p4 class=jo><p id=p5 class=bu><p id=p6 class=jo></span></div>"

      parser = Myhtml::Parser.new.parse(html)
      finder = parser.finder(".jo")

      10.times do
        parser.root!.css(finder).to_a.map(&.attribute_by("id")).should eq %w(p2 p4 p6)
      end
    end

    it "for parser" do
      html = "<div><p id=p1><p id=p2 class=jo><p id=p3><a>link</a><span id=bla><p id=p4 class=jo><p id=p5 class=bu><p id=p6 class=jo></span></div>"

      parser = Myhtml::Parser.new.parse(html)
      finder = parser.finder(".jo")

      10.times do
        parser.css(finder).to_a.map(&.attribute_by("id")).should eq %w(p2 p4 p6)
      end
    end

    it "for root node" do
      html = "<div><p id=p1><p id=p2 class=jo><p id=p3><a>link</a><span id=bla><p id=p4 class=jo><p id=p5 class=bu><p id=p6 class=jo></span></div>"

      parser = Myhtml::Parser.new.parse(html)
      finder = parser.finder(".jo")

      10.times do
        parser.root!.css(finder).to_a.map(&.attribute_by("id")).should eq %w(p2 p4 p6)
      end
    end
  end

  it "should not raise on empty selector" do
    html = "<div><p id=p1><p id=p2 class=jo><p id=p3><a>link</a><span id=bla><p id=p4 class=jo><p id=p5 class=bu><p id=p6 class=jo></span></div>"

    parser = Myhtml::Parser.new.parse(html)
    finder = parser.finder("")
    parser.css(finder).to_a.size.should eq 0
  end

  it "integration test" do
    html = <<-PAGE
      <div>
        <p id=p1>
        <p id=p2 class=jo>
        <p id=p3>
          <a href="some.html" id=a1>link1</a>
          <a href="some.png" id=a2>link2</a>
        <div id=bla>
          <p id=p4 class=jo>
          <p id=p5 class=bu>
          <p id=p6 class=jo>
        </div>
      </div>
    PAGE

    parser = Myhtml::Parser.new.parse(html)

    # select all p nodes which id like `*p*`
    parser.css("p[id*=p]").map(&.attribute_by("id")).to_a.should eq ["p1", "p2", "p3", "p4", "p5", "p6"]

    # select all nodes with class "jo"
    parser.css("p.jo").map(&.attribute_by("id")).to_a.should eq ["p2", "p4", "p6"]
    parser.css(".jo").map(&.attribute_by("id")).to_a.should eq ["p2", "p4", "p6"]

    # select odd child tag inside div, which not contain a
    parser.css("div > :nth-child(2n+1):not(:has(a))").map(&.attribute_by("id")).to_a.should eq ["p1", "p4", "p6"]

    # all elements with class=jo inside last div tag
    parser.css("div").to_a.last.css(".jo").map(&.attribute_by("id")).to_a.should eq ["p4", "p6"]

    # a element with href ends like .png
    parser.css(%q{a[href$=".png"]}).map(&.attribute_by("id")).to_a.should eq ["a2"]

    # find all a tags inside <p id=p3>, which href contain `html`
    parser.css(%q{p[id=p3] > a[href*="html"]}).map(&.attribute_by("id")).to_a.should eq ["a1"]

    # find all a tags inside <p id=p3>, which href contain `html` or ends_with `.png`
    parser.css(%q{p[id=p3] > a:matches([href *= "html"], [href $= ".png"])}).map(&.attribute_by("id")).to_a.should eq ["a1", "a2"]

    # create finder and use it in many places
    finder = Myhtml::Parser.finder(".jo")
    parser.css(finder).map(&.attribute_by("id")).to_a.should eq ["p2", "p4", "p6"]
  end
end
