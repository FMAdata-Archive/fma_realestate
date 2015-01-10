module FmaRealestate
  class PublicRecord < Client
    def search_by_address(params={})
      get('/api/data_quick_files/search_by_address', params)
    end

    def search_by_advanced(params={})
      get('/api/data_quick_files/search_by_advanced', params)
    end

    def search_by_address_advanced(params={})
      get('/api/data_quick_files/search_by_address_advanced', params)
    end
  end
end
