module FmaRealestate
  class Cass < Client
    def tiger(params={})
      get('/api/cass/tiger', params)
    end
  end
end
