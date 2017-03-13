require "myhtml"

struct Myhtml::Parser
  delegate :css, to: root!
end

struct Myhtml::Node
  def css(rule : String)
    f = Modest::Finder.new(rule)
    css(f)
  ensure
    f.try &.free
  end

  def css(finder : Modest::Finder)
    finder.find(self)
  end

  def css(arg)
    collection = css(arg)
    yield collection
  ensure
    collection.try &.free
  end
end
