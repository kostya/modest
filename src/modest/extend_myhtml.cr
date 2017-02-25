require "myhtml"

# TODO: remove?
struct Myhtml::Parser
  def finder(rule : String)
    Modest::Finder.new(rule)
  end

  def self.finder(rule : String)
    Modest::Finder.new(rule)
  end

  def css(rule : String)
    f = finder(rule)
    css(f)
  ensure
    f.try &.free
  end

  def css(finder : Modest::Finder)
    finder.find(root!)
  end
end

struct Myhtml::Node
  def css(rule : String)
    f = Myhtml::Parser.finder(rule)
    css(f)
  ensure
    f.try &.free
  end

  def css(finder : Modest::Finder)
    finder.find(self)
  end
end
