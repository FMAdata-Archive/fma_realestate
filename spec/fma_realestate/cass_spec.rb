require 'spec_helper'

describe FmaRealestate::Cass do
  let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => true) }
  let(:anonymous_client) { described_class.new(:raise_errors => true) }
  
  describe "#tiger" do
    context "with :raise_errors => false" do
      let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => false) }

      it_behaves_like "handles error suppression" do
        let(:action) { authenticated_client.tiger }
      end
    end

    context "with :raise_errors => true" do

      it_behaves_like "requires valid authentication" do
        let(:action) { anonymous_client.tiger }
      end

      it_behaves_like "handles 404 response" do
        let(:action) { authenticated_client.tiger }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.tiger }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.tiger }
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('cass_tiger') }
      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/cass/tiger', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        params = {:street_address => "1325 Pearl Street", :city => "Boulder", :state => "CO", :zip => "80302"}
        response = authenticated_client.tiger(params)
        expect(response.keys.count).to eq(30)
        expect(response['return_code']).to eq('1')
        expect(response['dpv_confirmation_indicator']).to eq('Y')
      end
    end
  end

  describe "#address" do
    context "with :raise_errors => false" do
      let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => false) }

      it_behaves_like "handles error suppression" do
        let(:action) { authenticated_client.address }
      end
    end

    context "with :raise_errors => true" do

      it_behaves_like "requires valid authentication" do
        let(:action) { anonymous_client.address }
      end

      it_behaves_like "handles 404 response" do
        let(:action) { authenticated_client.address }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.address }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.address }
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('cass_address') }
      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/cass/address', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        params = {:street_address => "1325 Pearl Street", :city => "Boulder", :state => "CO", :zip => "80302"}
        response = authenticated_client.address(params)
        expect(response.keys.count).to eq(24)
        expect(response['return_code']).to eq('1')
        expect(response['dpv_confirmation_indicator']).to eq('Y')
      end
    end
  end
end
