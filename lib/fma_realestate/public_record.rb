module FmaRealestate
  class PublicRecord < Client
    def search_by_address(params={})
      get('/api/data_quick_files/search_by_address', params)
    end
  end
end
