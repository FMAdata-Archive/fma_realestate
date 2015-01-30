module FmaRealestate
  class PublicRecordSale < Client
    def search_by_cass_search_key(params={})
      get('/api/public_record_sales/search_by_cass_search_key', params)
    end
  end
end
