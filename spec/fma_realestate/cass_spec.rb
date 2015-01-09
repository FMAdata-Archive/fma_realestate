require 'spec_helper'

describe FmaRealestate::Cass do
  
  describe ".tiger" do
    context "with :raise_errors => false" do
      it 'raises authentication error with invalid access_token' do
        Excon.stub({ :method => :get, :path => '/api/cass/tiger', :headers => { 'Authorization' => "Token token=test" }}, {:status => 401 })
        client = FmaRealestate::Cass.new(:access_token => 'test', :raise_errors => false)
        expect {client.tiger()}.to_not raise_error
      end
    end

    context "with :raise_errors => true" do
      it 'raises authentication error with invalid access_token' do
        Excon.stub({ :method => :get, :path => '/api/cass/tiger', :headers => { 'Authorization' => "Token token=test" }}, {:status => 401 })
        client = FmaRealestate::Cass.new(:access_token => 'test', :raise_errors => true)
        expect {client.tiger()}.to raise_error(FmaRealestate::AuthenticationError)
      end

      it 'raises authentication error with missing access_token' do
        Excon.stub({ :method => :get, :path => '/api/cass/tiger'}, {:status => 401 })
        client = FmaRealestate::Cass.new(:raise_errors => true)
        expect {client.tiger()}.to raise_error(FmaRealestate::AuthenticationError)
      end

      it 'raises not found error with 404 response' do
        Excon.stub({ :method => :get, :path => '/api/cass/tiger'}, {:status => 404 })
        client = FmaRealestate::Cass.new(:raise_errors => true)
        expect {client.tiger()}.to raise_error(FmaRealestate::ResourceNotFound)
      end

      it 'raises bad request error with 400 response' do
        Excon.stub({ :method => :get, :path => '/api/cass/tiger'}, {:status => 400 })
        client = FmaRealestate::Cass.new(:raise_errors => true)
        expect {client.tiger()}.to raise_error(FmaRealestate::BadRequest)
      end

      it 'raises http error with unexpected error response' do
        Excon.stub({ :method => :get, :path => '/api/cass/tiger'}, {:status => 403 })
        client = FmaRealestate::Cass.new(:raise_errors => true)
        expect {client.tiger()}.to raise_error(FmaRealestate::HTTPError)
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('tiger') }
      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/cass/tiger', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        client = FmaRealestate::Cass.new(:access_token => 'test', :raise_errors => true)
        params = {:street_address => "1325 Pearl Street", :city => "Boulder", :state => "CO", :zip => "80302"}
        response = client.tiger(params)
        expect(response.keys.count).to eq(28)
        expect(response['return_code']).to eq('1')
        expect(response['dpv_confirmation_indicator']).to eq('Y')
      end
    end
  end
end
