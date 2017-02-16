class Modest::Finder
  @finder : LibModest::ModestFinderT*

  def initialize(rule : String)
    @finder = LibModest.finder_create_simple
    @css = Mycss.new
    @selectors = Modest::LibMyCss.entry_selectors(@css.raw_entry)
    @list = LibMyCss.selectors_parse(@selectors, Myhtml::Lib::MyhtmlEncodingList::MyHTML_ENCODING_UTF_8, rule.to_unsafe, rule.bytesize, out status)
    if status != LibMyCss::MycssStatusT::MyCSS_STATUS_OK
      LibMyCss.selectors_list_destroy(@selectors, @list, true)
      LibModest.finder_destroy(@finder, true)
      raise Myhtml::Error.new("finder selectors_parse #{status}")
    end
    @finalized = false
  end

  def find(scope_node : Myhtml::Node)
    col = Pointer(Myhtml::Lib::MyhtmlCollectionT).new(0)
    LibModest.finder_by_selectors_list(@finder, scope_node.raw_node, @list, pointerof(col))
    Myhtml::CollectionIterator.new(scope_node.tree, col)
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
end
