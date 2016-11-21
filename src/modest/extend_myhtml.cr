struct Myhtml::Node
  # description of selectors: http://www.w3schools.com/cssref/css_selectors.asp
  def css(rule : String)
    finder = Modest::Finder.new(@tree, rule)
    finder.find(self)
  end
end
