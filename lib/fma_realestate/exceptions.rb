module FmaRealestate
  class RequestError < StandardError; end
  class AuthenticationError < RequestError; end
  class HTTPError < RequestError; end
  class BadRequest < RequestError; end
  class ResourceNotFound < RequestError; end
end
