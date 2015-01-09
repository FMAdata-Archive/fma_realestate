require 'excon'
require 'json'

require "fma_realestate/version"
require "fma_realestate/client"
require "fma_realestate/cass"
require "fma_realestate/exceptions"

module FmaRealestate

  def self.configure
    yield self
    true
  end

  class << self
    attr_accessor :access_token
  end

end
