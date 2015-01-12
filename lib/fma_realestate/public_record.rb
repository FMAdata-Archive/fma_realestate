module FmaRealestate
  class PublicRecord < Client
    def search_by_address(params={})
      get('/api/public_records/search_by_address', params)
    end

    def search_by_advanced(params={})
      get('/api/public_records/search_by_advanced', params)
    end

    def search_by_address_advanced(params={})
      get('/api/public_records/search_by_address_advanced', params)
    end

    def search_by_global(params={})
      get('/api/public_records/search_by_global', params)
    end
  end
end
