module Modest
  @[Link(ldflags: "#{__DIR__}/../ext/modest-c/lib/libmodest_static.a")]
  lib LibMyCss
    enum MycssStatusT
      MyCSS_STATUS_OK                                     = 0x000000
      MyCSS_STATUS_ERROR_MEMORY_ALLOCATION                = 0x010001
      MyCSS_STATUS_ERROR_TOKENIZER_STATE_ALLOCATION       = 0x010020
      MyCSS_STATUS_ERROR_TOKENIZER_INCOMING_BUFFER_ADD    = 0x010021
      MyCSS_STATUS_ERROR_TOKENIZER_TOKEN_ALLOCATION       = 0x010022
      MyCSS_STATUS_ERROR_INCOMING_BUFFER_INIT             = 0x010030
      MyCSS_STATUS_ERROR_ENTRY_INCOMING_BUFFER_CREATE     = 0x010039
      MyCSS_STATUS_ERROR_ENTRY_INCOMING_BUFFER_INIT       = 0x010040
      MyCSS_STATUS_ERROR_ENTRY_TOKEN_INCOMING_BUFFER_INIT = 0x010041
      MyCSS_STATUS_ERROR_ENTRY_TOKEN_NODE_ADD             = 0x010042
      MyCSS_STATUS_ERROR_SELECTORS_CREATE                 = 0x010100
      MyCSS_STATUS_ERROR_SELECTORS_ENTRIES_CREATE         = 0x010101
      MyCSS_STATUS_ERROR_SELECTORS_ENTRIES_INIT           = 0x010102
      MyCSS_STATUS_ERROR_SELECTORS_ENTRIES_NODE_ADD       = 0x010103
      MyCSS_STATUS_ERROR_SELECTORS_LIST_CREATE            = 0x010104
      MyCSS_STATUS_ERROR_SELECTORS_LIST_INIT              = 0x010105
      MyCSS_STATUS_ERROR_SELECTORS_LIST_ADD_NODE          = 0x010106
      MyCSS_STATUS_ERROR_NAMESPACE_CREATE                 = 0x010200
      MyCSS_STATUS_ERROR_NAMESPACE_INIT                   = 0x010201
      MyCSS_STATUS_ERROR_NAMESPACE_ENTRIES_CREATE         = 0x010202
      MyCSS_STATUS_ERROR_NAMESPACE_ENTRIES_INIT           = 0x010203
      MyCSS_STATUS_ERROR_NAMESPACE_NODE_ADD               = 0x010204
      MyCSS_STATUS_ERROR_MEDIA_CREATE                     = 0x010404
      MyCSS_STATUS_ERROR_STRING_CREATE                    = 0x010501
      MyCSS_STATUS_ERROR_STRING_INIT                      = 0x010502
      MyCSS_STATUS_ERROR_STRING_NODE_INIT                 = 0x010503
      MyCSS_STATUS_ERROR_AN_PLUS_B_CREATE                 = 0x010600
      MyCSS_STATUS_ERROR_AN_PLUS_B_INIT                   = 0x010601
      MyCSS_STATUS_ERROR_DECLARATION_CREATE               = 0x010700
      MyCSS_STATUS_ERROR_DECLARATION_INIT                 = 0x010701
      MyCSS_STATUS_ERROR_DECLARATION_ENTRY_CREATE         = 0x010702
      MyCSS_STATUS_ERROR_DECLARATION_ENTRY_INIT           = 0x010703
      MyCSS_STATUS_ERROR_PARSER_LIST_CREATE               = 0x010800
    end

    # mycss
    type MycssT = Void*
    type MycssEntryT = Void*
    type MysccSelectorsListT = Void*
    type MysccSelectorsT = Void*
    type MycssStylesheeT = Void*

    fun create = mycss_create : MycssT*
    fun init = mycss_init(mycss : MycssT*) : MycssStatusT
    fun entry_create = mycss_entry_create : MycssEntryT*
    fun entry_init = mycss_entry_init(mycss : MycssT*, entry : MycssEntryT*) : MycssStatusT
    fun selectors_parse = mycss_selectors_parse(selectors : MysccSelectorsT*, encoding : Myhtml::Lib::MyhtmlEncodingList,
                                                data : UInt8*, data_size : LibC::SizeT, out_status : MycssStatusT*) : MysccSelectorsListT*
    fun selectors_list_destroy = mycss_selectors_list_destroy(selectors : MysccSelectorsT*, selector_list : MysccSelectorsListT*, self_destroy : Bool) : MysccSelectorsListT*

    fun get_jopa = mycss_get_jopa(entry : MycssEntryT*) : MysccSelectorsT*
    fun destroy = mycss_destroy(mycss : MycssT*, self_destroy : Bool) : MycssT*
    fun entry_destroy = mycss_entry_destroy(entry : MycssEntryT*, self_destroy : Bool) : MycssEntryT*
  end

  # cd src/ext && make
  @[Link(ldflags: "#{__DIR__}/../ext/modest-c/lib/libmodest_static.a")]
  lib LibModest
    # modest
    type ModestFinderT = Void*

    fun finder_create_simple = modest_finder_create_simple(tree : Myhtml::Lib::MyhtmlTreeT*, stylesheet : LibMyCss::MycssStylesheeT*) : ModestFinderT*
    fun finder_destroy = modest_finder_destroy(finder : ModestFinderT*, self_destroy : Bool) : ModestFinderT*

    fun finder_by_selectors_list = modest_finder_by_selectors_list(finder : ModestFinderT*, sel_list : LibMyCss::MysccSelectorsListT*,
                                                                   base_node : Myhtml::Lib::MyhtmlTreeNodeT*, collection : Myhtml::Lib::MyhtmlCollectionT*) : Myhtml::Lib::MyhtmlCollectionT*

    # modest_finder_t * modest_finder_create_simple(myhtml_tree_t* myhtml_tree, mycss_stylesheet_t *stylesheet);

    # modest_finder_t * modest_finder_create(void);
    # modest_status_t modest_finder_init(modest_finder_t* finder, myhtml_tree_t* myhtml_tree, mycss_stylesheet_t *stylesheet);
    # void modest_finder_clean(modest_finder_t* finder);
    # modest_finder_t * modest_finder_destroy(modest_finder_t* finder, bool self_destroy);

    # type MyhtmlT = Void*
    # type MyhtmlTreeT = Void*
    # type MyhtmlTreeNodeT = Void*
    # type MyhtmlTreeAttrT = Void*
    # type MyhtmlTagIndexT = Void*
    # type MyhtmlTagIndexNodeT = Void*
    # alias MyhtmlTagIdT = MyhtmlTags
    # type MyhtmlCallbackSerializeF = UInt8*, LibC::SizeT, Void* ->

    # struct MyhtmlVersion
    #   major : Int32
    #   minor : Int32
    #   patch : Int32
    # end

    # struct MyhtmlStringRawT
    #   data : UInt8*
    #   size : LibC::SizeT
    #   length : LibC::SizeT
    # end

    # struct MyhtmlCollectionT
    #   list : MyhtmlTreeNodeT**
    #   size : LibC::SizeT
    #   length : LibC::SizeT
    # end

    # fun create = myhtml_create : MyhtmlT*
    # fun init = myhtml_init(myhtml : MyhtmlT*, opt : MyhtmlOptions, thread_count : LibC::SizeT, queue_size : LibC::SizeT) : MyhtmlStatus

    # fun tree_create = myhtml_tree_create : MyhtmlTreeT*
    # fun tree_init = myhtml_tree_init(tree : MyhtmlTreeT*, myhtml : MyhtmlT*) : MyhtmlStatus

    # fun tree_destroy = myhtml_tree_destroy(tree : MyhtmlTreeT*) : MyhtmlTreeT*
    # fun destroy = myhtml_destroy(myhtml : MyhtmlT*) : MyhtmlT*

    # fun tree_parse_flags_set = myhtml_tree_parse_flags_set(tree : MyhtmlTreeT*, parse_flags : MyhtmlTreeParseFlags)

    # fun parse = myhtml_parse(tree : MyhtmlTreeT*, encoding : MyhtmlEncodingList, html : UInt8*, html_size : LibC::SizeT) : MyhtmlStatus

    # fun encoding_detect_and_cut_bom = myhtml_encoding_detect_and_cut_bom(text : UInt8*, length : LibC::SizeT, encoding : MyhtmlEncodingList*, new_text : UInt8**, new_size : LibC::SizeT*) : Bool
    # fun version = myhtml_version : MyhtmlVersion

    # fun tree_get_document = myhtml_tree_get_document(tree : MyhtmlTreeT*) : MyhtmlTreeNodeT*
    # fun tree_get_node_html = myhtml_tree_get_node_html(tree : MyhtmlTreeT*) : MyhtmlTreeNodeT*
    # fun tree_get_node_head = myhtml_tree_get_node_head(tree : MyhtmlTreeT*) : MyhtmlTreeNodeT*
    # fun tree_get_node_body = myhtml_tree_get_node_body(tree : MyhtmlTreeT*) : MyhtmlTreeNodeT*

    # fun node_child = myhtml_node_child(node : MyhtmlTreeNodeT*) : MyhtmlTreeNodeT*
    # fun node_next = myhtml_node_next(node : MyhtmlTreeNodeT*) : MyhtmlTreeNodeT*
    # fun node_parent = myhtml_node_parent(node : MyhtmlTreeNodeT*) : MyhtmlTreeNodeT*
    # fun node_prev = myhtml_node_prev(node : MyhtmlTreeNodeT*) : MyhtmlTreeNodeT*
    # fun node_last_child = myhtml_node_last_child(node : MyhtmlTreeNodeT*) : MyhtmlTreeNodeT*
    # fun node_remove = myhtml_node_remove(tree : MyhtmlTreeT*, node : MyhtmlTreeNodeT*)

    # fun node_set_data = myhtml_node_set_data(node : MyhtmlTreeNodeT*, data : Void*)
    # fun node_get_data = myhtml_node_get_data(node : MyhtmlTreeNodeT*) : Void*

    # fun tag_name_by_id = myhtml_tag_name_by_id(tree : MyhtmlTreeT*, tag_id : MyhtmlTagIdT, length : LibC::SizeT*) : UInt8*
    # fun node_tag_id = myhtml_node_tag_id(node : MyhtmlTreeNodeT*) : MyhtmlTagIdT
    # fun node_text = myhtml_node_text(node : MyhtmlTreeNodeT*, length : LibC::SizeT*) : UInt8*

    # fun node_attribute_first = myhtml_node_attribute_first(node : MyhtmlTreeNodeT*) : MyhtmlTreeAttrT*
    # fun attribute_key = myhtml_attribute_key(attr : MyhtmlTreeAttrT*, length : LibC::SizeT*) : UInt8*
    # fun attribute_value = myhtml_attribute_value(attr : MyhtmlTreeAttrT*, length : LibC::SizeT*) : UInt8*
    # fun attribute_next = myhtml_attribute_next(attr : MyhtmlTreeAttrT*) : MyhtmlTreeAttrT*

    # fun tree_get_tag_index = myhtml_tree_get_tag_index(tree : MyhtmlTreeT*) : MyhtmlTagIndexT*
    # fun tag_index_first = myhtml_tag_index_first(tag_index : MyhtmlTagIndexT*, tag_id : MyhtmlTagIdT) : MyhtmlTagIndexNodeT*
    # fun tag_index_entry_count = myhtml_tag_index_entry_count(tag_index : MyhtmlTagIndexT*, tag_id : MyhtmlTagIdT) : LibC::SizeT
    # fun tag_index_tree_node = myhtml_tag_index_tree_node(index_node : MyhtmlTagIndexNodeT*) : MyhtmlTreeNodeT*
    # fun tag_index_next = myhtml_tag_index_next(index_node : MyhtmlTagIndexNodeT*) : MyhtmlTagIndexNodeT*

    # fun serialization = myhtml_serialization(tree : MyhtmlTreeT*, node : MyhtmlTreeNodeT*, str : MyhtmlStringRawT*) : Bool
    # fun serialization_node = myhtml_serialization_node(tree : MyhtmlTreeT*, node : MyhtmlTreeNodeT*, str : MyhtmlStringRawT*) : Bool

    # fun string_raw_clean_all = myhtml_string_raw_clean_all(str_raw : MyhtmlStringRawT*)
    # fun string_raw_destroy = myhtml_string_raw_destroy(str_raw : MyhtmlStringRawT*, destroy_obj : Bool) : MyhtmlStringRawT*

    # fun get_nodes_by_attribute_value = myhtml_get_nodes_by_attribute_value(tree : MyhtmlTreeT*,
    #                                                                        collection : MyhtmlCollectionT*, node : MyhtmlTreeNodeT*, case_insensitive : Bool, key : UInt8*, key_len : LibC::SizeT,
    #                                                                        value : UInt8*, value_len : LibC::SizeT, status : MyhtmlStatus*) : MyhtmlCollectionT*
    # fun collection_destroy = myhtml_collection_destroy(collection : MyhtmlCollectionT*) : MyhtmlCollectionT*
  end
end
