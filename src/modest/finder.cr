class Modest::Finder
  @finder : LibModest::ModestFinderT*

  def initialize(@rule : String)
    @finalized = false
    @finder = LibModest.finder_create_simple
    @css = Mycss.new
    @selectors = Modest::LibMyCss.entry_selectors(@css.raw_entry)
    @list = LibMyCss.selectors_parse(@selectors, Myhtml::Lib::MyEncodingList::MyENCODING_UTF_8, rule.to_unsafe, rule.bytesize, out status)
    if status != LibMyCss::MycssStatusT::MyCSS_STATUS_OK
      free
      raise Myhtml::Error.new("finder selectors_parse #{status}")
    end
  end

  def find(scope_node : Myhtml::Node)
    col = Pointer(Myhtml::Lib::MyhtmlCollectionT).new(0)
    LibModest.finder_by_selectors_list(@finder, scope_node.raw_node, @list, pointerof(col))
    Myhtml::Iterator.new(scope_node.tree, col)
  end

  def free
    unless @finalized
      @finalized = true
      LibMyCss.selectors_list_destroy(@selectors, @list, true)
      LibModest.finder_destroy(@finder, true)
      @css.free
    end
  end

  def finalize
    free
  end

  def inspect(io)
    io << "Modest::Finder(rule: `"
    io << @rule
    io << "`)"
  end
end
