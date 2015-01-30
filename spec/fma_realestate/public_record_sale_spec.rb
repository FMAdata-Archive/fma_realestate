require 'spec_helper'

describe FmaRealestate::PublicRecordSale do
  let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => true) }
  let(:anonymous_client) { described_class.new(:raise_errors => true) }

  describe "#search_by_cass_search_key" do
    context "with :raise_errors => false" do
      let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => false) }

      it_behaves_like "handles error suppression" do
        let(:action) { authenticated_client.search_by_cass_search_key }
      end
    end

    context "with :raise_errors => true" do

      it_behaves_like "requires valid authentication" do
        let(:action) { anonymous_client.search_by_cass_search_key }
      end

      it_behaves_like "handles 404 response" do
        let(:action) { authenticated_client.search_by_cass_search_key }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.search_by_cass_search_key }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.search_by_cass_search_key }
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('public_record_sale/search_by_cass_search_key') }

      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/public_record_sales/search_by_cass_search_key', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        params = {:cass_search_key => "90803513805UNIT405"}
        response = authenticated_client.search_by_cass_search_key(params)
        expect(response["count"]).to be_a Integer
        expect(response["results"]).to be_a Array
        expect(response["results"].count).to eq(1)
        expect(response["results"].first).to be_a Hash
      end
    end
  end
end
