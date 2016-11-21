struct Modest::Finder
  @finder : ModestFinderT*

  def initialize(@tree : Myhtml::Tree, rule : String)
    @finder = LibModest.finder_create_simple(@tree.raw_tree, nil)
    @css = Mycss.new
    @list = LibMycss.selectors_parse(css_entry->selectors, Myhtml::Lib::MyhtmlEncodingList::MyHTML_ENCODING_UTF_8, rule.to_unsave, rule.bytesize, out status)
    if status != LibMyCss::MycssStatusT::MyCSS_STATUS_OK
      raise Myhtml::Error.new("finder selectors_parse #{status}")
    end
  end

  def find(scope_node : Myhtml::Node)
    col = LibModest.finder_by_selectors_list(@finder, @list, scope_node.raw_node, nil)
    CollectionIterator.new(@tree, col)
  end

  def finalize
    LibModest.finder_destroy(@finder, true)
  end
end
