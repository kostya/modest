struct Myhtml::Node
  def css(rule : String)
    finder = Modest::Finder.new(@tree, rule)
    finder.find(self)
  end
end
