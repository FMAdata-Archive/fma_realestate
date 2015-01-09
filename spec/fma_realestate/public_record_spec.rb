require 'spec_helper'

describe FmaRealestate::PublicRecord do
  
  describe ".search_by_address" do
    context "with :raise_errors => false" do
      it 'raises authentication error with invalid access_token' do
        Excon.stub({ :method => :get, :path => '/api/data_quick_files/search_by_address', :headers => { 'Authorization' => "Token token=test" }}, {:status => 401 })
        client = FmaRealestate::PublicRecord.new(:access_token => 'test', :raise_errors => false)
        expect {client.search_by_address()}.to_not raise_error
      end
    end

    context "with :raise_errors => true" do
      it 'raises authentication error with invalid access_token' do
        Excon.stub({ :method => :get, :path => '/api/data_quick_files/search_by_address', :headers => { 'Authorization' => "Token token=test" }}, {:status => 401 })
        client = FmaRealestate::PublicRecord.new(:access_token => 'test', :raise_errors => true)
        expect {client.search_by_address()}.to raise_error(FmaRealestate::AuthenticationError)
      end

      it 'raises authentication error with missing access_token' do
        Excon.stub({ :method => :get, :path => '/api/data_quick_files/search_by_address'}, {:status => 401 })
        client = FmaRealestate::PublicRecord.new(:raise_errors => true)
        expect {client.search_by_address()}.to raise_error(FmaRealestate::AuthenticationError)
      end

      it 'raises not found error with 404 response' do
        Excon.stub({ :method => :get, :path => '/api/data_quick_files/search_by_address'}, {:status => 404 })
        client = FmaRealestate::PublicRecord.new(:raise_errors => true)
        expect {client.search_by_address()}.to raise_error(FmaRealestate::ResourceNotFound)
      end

      it 'raises bad request error with 400 response' do
        Excon.stub({ :method => :get, :path => '/api/data_quick_files/search_by_address'}, {:status => 400 })
        client = FmaRealestate::PublicRecord.new(:raise_errors => true)
        expect {client.search_by_address()}.to raise_error(FmaRealestate::BadRequest)
      end

      it 'raises http error with unexpected error response' do
        Excon.stub({ :method => :get, :path => '/api/data_quick_files/search_by_address'}, {:status => 403 })
        client = FmaRealestate::PublicRecord.new(:raise_errors => true)
        expect {client.search_by_address()}.to raise_error(FmaRealestate::HTTPError)
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('search_by_address') }
      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/data_quick_files/search_by_address', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        client = FmaRealestate::PublicRecord.new(:access_token => 'test', :raise_errors => true)
        params = {:street_address => "1325 Pearl Street", :city => "Boulder", :state => "CO", :zip => "80302"}
        response = client.search_by_address(params)
        expect(response["cass"]).to be_a Hash
        expect(response["count"]).to be_a Integer
        expect(response["results"]).to be_a Array
        expect(response["results"].count).to eq(1)
        expect(response["results"].first).to be_a Hash
      end
    end
  end
end
