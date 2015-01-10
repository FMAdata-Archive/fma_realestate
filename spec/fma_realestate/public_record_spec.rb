require 'spec_helper'

describe FmaRealestate::PublicRecord do
  let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => true) }
  let(:anonymous_client) { described_class.new(:raise_errors => true) }

  describe "#search_by_address" do
    context "with :raise_errors => false" do
      let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => false) }

      it_behaves_like "handles error suppression" do
        let(:action) { authenticated_client.search_by_address }
      end
    end

    context "with :raise_errors => true" do

      it_behaves_like "requires valid authentication" do
        let(:action) { anonymous_client.search_by_address }
      end

      it_behaves_like "handles 404 response" do
        let(:action) { authenticated_client.search_by_address }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.search_by_address }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.search_by_address }
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('search_by_address') }

      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/data_quick_files/search_by_address', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        params = {:street_address => "1325 Pearl Street", :city => "Boulder", :state => "CO", :zip => "80302"}
        response = authenticated_client.search_by_address(params)
        expect(response["cass"]).to be_a Hash
        expect(response["count"]).to be_a Integer
        expect(response["results"]).to be_a Array
        expect(response["results"].count).to eq(1)
        expect(response["results"].first).to be_a Hash
      end
    end
  end

  describe "#search_by_advanced" do
    context "with :raise_errors => false" do
      let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => false) }

      it_behaves_like "handles error suppression" do
        let(:action) { authenticated_client.search_by_advanced }
      end
    end

    context "with :raise_errors => true" do

      it_behaves_like "requires valid authentication" do
        let(:action) { anonymous_client.search_by_advanced }
      end

      it_behaves_like "handles 404 response" do
        let(:action) { authenticated_client.search_by_advanced }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.search_by_advanced }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.search_by_advanced }
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('search_by_advanced') }

      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/data_quick_files/search_by_advanced', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        params = {:street_address => "1325 Pearl Street", :city => "Boulder", :state => "CO", :zip => "80302"}
        response = authenticated_client.search_by_advanced(params)
        expect(response["count"]).to be_a Integer
        expect(response["results"]).to be_a Array
        expect(response["results"].count).to eq(1)
        expect(response["results"].first).to be_a Hash
        expect(response["results"][0]["result"]).to be_a Hash
        expect(response["results"][0]["weight"]).to be_a Integer
      end
    end
  end

  describe "#search_by_address_advanced" do
    context "with :raise_errors => false" do
      let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => false) }

      it_behaves_like "handles error suppression" do
        let(:action) { authenticated_client.search_by_address_advanced }
      end
    end

    context "with :raise_errors => true" do

      it_behaves_like "requires valid authentication" do
        let(:action) { anonymous_client.search_by_address_advanced }
      end

      it_behaves_like "handles 404 response" do
        let(:action) { authenticated_client.search_by_address_advanced }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.search_by_address_advanced }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.search_by_address_advanced }
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('search_by_address_advanced') }

      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/data_quick_files/search_by_address_advanced', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        params = {:street_address => "1325 Pearl Street", :city => "Boulder", :state => "CO", :zip => "80302"}
        response = authenticated_client.search_by_address_advanced(params)
        expect(response["cass"]).to be_a Hash
        expect(response["count"]).to be_a Integer
        expect(response["results"]).to be_a Array
        expect(response["results"].count).to eq(1)
        expect(response["results"].first).to be_a Hash
      end
    end
  end
end
