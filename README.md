# FmaRealestate

FMA Real Estate and CASS Ruby Client

## Installation

Add this line to your application's Gemfile:

    gem 'fma_realestate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fma_realestate

## Requirements

* Ruby 1.8.7 or above

## Usage

```ruby
# Global config
# if using rails, create initializer: /config/initializers/fma_realestate.rb
FmaRealestate.configure do |config|
  config.access_token = 'your_access_token'
end

# or

FmaRealestate.access_token = 'your_access_token'
```

```ruby
# Sample client configuration, shown with default values:
config = {
  :access_token => FmaRealestate.access_token,  # initialize the client with an access token
  :raise_errors => false,                       # choose between returning false or raising a proper exception when API calls fails

  # Connection properties
  :retries       => 0,    # automatically retry a certain number of times before returning
  :read_timeout  => 10,   # set longer read_timeout, default is 10 seconds
  :write_timeout => 10,   # set longer write_timeout, default is 10 seconds
  :persistent    => false # when true, make multiple requests calls using a single persistent connection. Use +close_connection+ method on the client to manually clean up sockets
}
```

```ruby
# Example Cass client usage
cass_client = Cass.new # using default config

# Cass#tiger
response_hash = cass_client.tiger(
  :street_address => "123 N Easy St.", # optional
  :city           => "Boulder",        # optional
  :state          => "CO",             # optional
  :zip            => ""                # optional
)

# Cass#address
response_hash = cass_client.address(
  :street_address => "123 N Easy St.", # optional
  :city           => "Boulder",        # optional
  :state          => "CO",             # optional
  :zip            => ""                # optional
)

# Cass#city_zip
response_hash = cass_client.city_zip(
  :city           => "Boulder",        # optional
  :state          => "CO",             # optional
)

# Cass#city_county
response_hash = cass_client.city_county(
  :zip            => "80302"           # optional
)

# Cass#state_county
response_hash = cass_client.state_county(
  :state          => "CO",             # optional
)
```

```ruby
# Example PublicRecord client usage
public_record_client = RealEstate.new # using default config

# PublicRecord#search_by_address
response_hash = public_record_client.search_by_address(
  :street_address => "123 N Easy St.", # optional
  :city           => "Boulder",        # optional
  :state          => "CO",             # optional
  :zip            => ""                # optional
)

# PublicRecord#search_by_advanced
response_hash = public_record_client.search_by_advanced(
  :legal_description => ""                # optional
  :owner_name        => "Jon Doe"         # optional
  :street_address    => "123 N Easy St.", # optional
  :city              => "Boulder",        # optional
  :state             => "CO",             # optional
  :zip               => "",               # optional
  :county            => "Boulder"         # optional
)

# PublicRecord#search_by_address_advanced
response_hash = public_record_client.search_by_address_advanced(
  :legal_description => ""                # optional
  :owner_name        => "Jon Doe"         # optional
  :street_address    => "123 N Easy St.", # optional
  :city              => "Boulder",        # optional
  :state             => "CO",             # optional
  :zip               => "",               # optional
  :county            => "Boulder"         # optional
)

# PublicRecord#search_by_global
response_hash = public_record_client.search_by_address_advanced(
  :q => "123 N Easy St." # required
)
```

## FmaRealstate API Reference
Please refer to the <a href="http://realestate.firstmoversadvantage.com/api_documentation" target="_blank">official api documentation</a>

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fma_realestate/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
