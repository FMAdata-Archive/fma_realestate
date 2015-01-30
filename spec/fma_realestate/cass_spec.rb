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
      let(:fixture) { request_fixture('cass/tiger') }
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
      let(:fixture) { request_fixture('cass/address') }
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

  describe "#city_zip" do
    context "with :raise_errors => false" do
      let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => false) }

      it_behaves_like "handles error suppression" do
        let(:action) { authenticated_client.city_zip }
      end
    end

    context "with :raise_errors => true" do

      it_behaves_like "requires valid authentication" do
        let(:action) { anonymous_client.city_zip }
      end

      it_behaves_like "handles 404 response" do
        let(:action) { authenticated_client.city_zip }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.city_zip }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.city_zip }
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('cass/city_zip') }
      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/cass/city_zip', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        params = {:city => "Boulder", :state => "CO"}
        response = authenticated_client.city_zip(params)
        expect(response.keys.count).to eq(4)
        expect(response['return_code']).to eq('11')
      end
    end
  end

  describe "#city_county" do
    context "with :raise_errors => false" do
      let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => false) }

      it_behaves_like "handles error suppression" do
        let(:action) { authenticated_client.city_county }
      end
    end

    context "with :raise_errors => true" do

      it_behaves_like "requires valid authentication" do
        let(:action) { anonymous_client.city_county }
      end

      it_behaves_like "handles 404 response" do
        let(:action) { authenticated_client.city_county }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.city_county }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.city_county }
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('cass/city_county') }
      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/cass/city_county', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        params = {:zip => "80302"}
        response = authenticated_client.city_county(params)
        expect(response.keys.count).to eq(5)
        expect(response['return_code']).to eq('0')
      end
    end
  end

  describe "#state_county" do
    context "with :raise_errors => false" do
      let(:authenticated_client) { described_class.new(:access_token => 'test', :raise_errors => false) }

      it_behaves_like "handles error suppression" do
        let(:action) { authenticated_client.state_county }
      end
    end

    context "with :raise_errors => true" do

      it_behaves_like "requires valid authentication" do
        let(:action) { anonymous_client.state_county }
      end

      it_behaves_like "handles 404 response" do
        let(:action) { authenticated_client.state_county }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.state_county }
      end

      it_behaves_like "handles 400 response" do
        let(:action) { authenticated_client.state_county }
      end
    end

    context "with valid access_token" do
      let(:fixture) { request_fixture('cass/state_county') }
      it "should get response" do
        Excon.stub({ :method => :get, :path => '/api/cass/state_county', :headers => { 'Authorization' => "Token token=test" }}, {:status => 200, :body => fixture })
        params = {:state => "CO"}
        response = authenticated_client.state_county(params)
        expect(response.keys.count).to eq(4)
        expect(response['return_code']).to eq('64')
      end
    end
  end
end
