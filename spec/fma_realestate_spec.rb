require 'spec_helper'

describe FmaRealestate do
  it 'has a version number' do
    expect(FmaRealestate::VERSION).not_to be nil
  end

  describe ".configure" do
    it 'should set the access_token' do
      FmaRealestate.configure do |config|
        config.access_token = "some_token"
      end
      expect(FmaRealestate.access_token).to eq("some_token")
    end
  end
end
