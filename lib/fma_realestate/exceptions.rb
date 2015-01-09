module FmaRealestate
  class Error < StandardError; end
  class AuthenticationError < Error; end
  class HTTPError < Error; end
  class BadRequest < Error; end
  class ResourceNotFound < Error; end
end
