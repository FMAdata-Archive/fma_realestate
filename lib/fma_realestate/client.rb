module FmaRealestate
  class Client
    BASE_URI = 'http://realestate.firstmoversadvantage.com'.freeze

    def initialize(config = {})
      @access_token  = config[:access_token] || FmaRealestate.access_token
      @raise_errors  = config[:raise_errors] || false
      @retries       = config[:retries] || 0
      @read_timeout  = config[:read_timeout] || 10
      @write_timeout = config[:write_timeout] || 10
      @connection    = Excon.new(BASE_URI, :persistent => config[:persistent] || false)
    end

    # Closes the connection underlying socket.
    # Use when you employ persistent connections and are done with your requests.
    def close_connection
      @connection.reset
    end

    protected

    def get(path, params = {})
      run(:get, path, [200], params)
    end

    def run(verb, path, expected_status_codes, params_or_body = nil, idempotent = true)
      packet = {
        :idempotent => idempotent,
        :expects => expected_status_codes,
        :method => verb,
        :path => path,
        :read_timeout => @read_timeout,
        :write_timeout => @write_timeout,
        :retry_limit => @retries,
        :headers => {
          'Accept' => 'application/json',
          'User-Agent'   => 'FmaRealestate Ruby Client'
        }
      }
      if params_or_body.is_a?(Hash)
        packet.merge!(:query => params_or_body)
      else
        packet.merge!(:body => params_or_body)
      end

      if !@access_token.nil? && @access_token != ''
        packet[:headers].merge!('Authorization' => "Token token=#{@access_token}")
      end

      response = request_error_handler do
        @connection.request(packet)
      end

      response ? ::JSON.load(response.body) : false
    end

    def request_error_handler(&blk)
      begin
        yield blk if block_given?
      rescue Excon::Errors::NotFound => exception
        raise(ResourceNotFound, "Error: #{exception.message}")
      rescue Excon::Errors::BadRequest => exception
        raise(BadRequest, "Error: #{exception.message}")
      rescue Excon::Errors::Unauthorized => exception
        raise(AuthenticationError, "Error: #{exception.message}")
      rescue Excon::Errors::Error => exception
        # Catch all others errors. Samples:
        #
        # <Excon::Errors::SocketError: Connection refused - connect(2) (Errno::ECONNREFUSED)>
        # <Excon::Errors::InternalServerError: Expected([200, 204, 404]) <=> Actual(500 InternalServerError)>
        # <Excon::Errors::Timeout: read timeout reached>
        # <Excon::Errors::BadGateway: Expected([200]) <=> Actual(502 Bad Gateway)>
        raise(HTTPError, "Error: #{exception.message}")
      end
    rescue RequestError
      @raise_errors ? raise : false
    end
  end
end
