struct Myhtml::Parser
  def finder(rule : String)
    Modest::Finder.new(@tree, rule)
  end
end

struct Myhtml::Node
  # description of selectors: http://www.w3schools.com/cssref/css_selectors.asp

  def css(rule : String)
    finder(rule).find(self)
  end

  def css(finder : Modest::Finder)
    finder.find(self)
  end

  def finder(rule : String)
    Modest::Finder.new(@tree, rule)
  end
end
