# TODO: remove
struct Myhtml::Parser
  def finder(rule : String) # TODO: move this to tree
    Modest::Finder.new(@tree, rule)
  end

  def css(rule : String) # TODO: delerate this to root!
    finder(rule).find(root!)
  end

  def css(finder : Modest::Finder)
    finder.find(root!)
  end
end

struct Myhtml::Node
  def css(rule : String)
    f = finder(rule)
    f.find(self)
  ensure
    f.try &.free
  end

  def css(finder : Modest::Finder)
    finder.find(self) # # TODO: delerate this to self
  end

  def finder(rule : String)
    Modest::Finder.new(@tree, rule)
  end
end

struct Myhtml::CollectionIterator
  def css(rule : String)
    f = finder(rule)
    f.find(self)
  ensure
    f.try &.free
  end

  def css(finder : Modest::Finder)
    finder.find(self)
  end

  def finder(rule : String)
    Modest::Finder.new(@tree, rule)
  end
end
