shared_examples "requires valid authentication" do
  it "raises authentication error" do
    Excon.stub({ :method => :get, :path => path, :headers => headers}, {:status => 401 })
    expect {action}.to raise_error(FmaRealestate::AuthenticationError)
  end
end

shared_examples "handles 404 response" do
  it "raises not found error" do
    Excon.stub({ :method => :get, :path => path, :headers => headers}, {:status => 404 })
    expect {action}.to raise_error(FmaRealestate::ResourceNotFound)
  end
end

shared_examples "handles 400 response" do
  it "raises not found error" do
    Excon.stub({ :method => :get, :path => path, :headers => headers}, {:status => 400 })
    expect {action}.to raise_error(FmaRealestate::BadRequest)
  end
end

shared_examples "handles unexpected response" do
  it "raises not found error" do
    Excon.stub({ :method => :get, :path => path, :headers => headers}, {:status => 403 })
    expect {action}.to raise_error(FmaRealestate::HTTPError)
  end
end

shared_examples "handles error suppression" do
  it 'suppresses request error' do
    connection = double("connection")
    allow(connection).to receive(:request) { raise FmaRealestate::RequestError }
    authenticated_client.instance_variable_set(:@connection, connection)
    expect {action}.to_not raise_error
  end

  it "doesn't suppress non request errors" do
    connection = double("connection")
    allow(connection).to receive(:request) { raise StandardError }
    authenticated_client.instance_variable_set(:@connection, connection)
    expect {action}.to raise_error
  end
end
