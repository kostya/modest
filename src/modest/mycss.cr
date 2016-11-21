class Modest::Mycss
  def initialize
    @mycss = LibMyCss.create
    status = LibMyCss.init(@mycss)
    if status != LibMyCss::MycssStatusT::MyCSS_STATUS_OK
      raise Myhtml::Error.new("mycss init error #{status}")
    end
    @entry = LibMyCss.entry_create
    status = LibMyCss.entry_init(@mycss, @entry)
    if status != LibMyCss::MycssStatusT::MyCSS_STATUS_OK
      LibMyCss.destroy(@mycss, true)
      raise Myhtml::Error.new("mycss entry_init error #{status}")
    end
    @finalized = false
  end

  def free
    unless @finalized
      @finalized = true
      LibMyCss.entry_destroy(@entry, true)
      LibMyCss.destroy(@mycss, true)
    end
  end

  def finalize
    free
  end
end
