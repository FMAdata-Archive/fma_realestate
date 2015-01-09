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
