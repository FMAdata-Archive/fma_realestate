module FmaRealestate
  class Cass < Client
    def tiger(params={})
      get('/api/cass/tiger', params)
    end

    def address(params={})
      get('/api/cass/address', params)
    end
  end
end
