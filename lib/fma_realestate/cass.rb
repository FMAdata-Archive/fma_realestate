module FmaRealestate
  class Cass < Client
    def tiger(params={})
      get('/api/cass/tiger', params)
    end

    def address(params={})
      get('/api/cass/address', params)
    end

    def city_zip(params={})
      get('/api/cass/city_zip', params)
    end
  end
end
