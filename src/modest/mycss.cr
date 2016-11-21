class Modest::Mycss
  getter raw_mycss, raw_entry

  def initialize
    @raw_mycss = LibMyCss.create
    status = LibMyCss.init(@raw_mycss)
    if status != LibMyCss::MycssStatusT::MyCSS_STATUS_OK
      raise Myhtml::Error.new("mycss init error #{status}")
    end
    @raw_entry = LibMyCss.entry_create
    status = LibMyCss.entry_init(@raw_mycss, @raw_entry)
    if status != LibMyCss::MycssStatusT::MyCSS_STATUS_OK
      LibMyCss.destroy(@raw_mycss, true)
      raise Myhtml::Error.new("mycss entry_init error #{status}")
    end
    @finalized = false
  end

  def free
    unless @finalized
      @finalized = true
      LibMyCss.entry_destroy(@raw_entry, true)
      LibMyCss.destroy(@raw_mycss, true)
    end
  end

  def finalize
    free
  end
end
