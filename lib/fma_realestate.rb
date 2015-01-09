require "fma_realestate/version"

module FmaRealestate

  def self.configure
    yield self
    true
  end

  class << self
    attr_accessor :access_token
  end

end
