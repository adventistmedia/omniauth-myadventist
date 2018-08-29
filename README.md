# Omniauth::Myadventist

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-myadventist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-myadventist

## Usage

The following is a simple example of using myadventist within your rails application.
To begin you'll need to setup an omniauth initializer. In config/initializers/omniauth.rb add:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :myadventist, Rails.application.secrets.myadventist_client_id, Rails.application.secrets.myadventist_client_secret
end
```

To use https://test.myadventist.org you can override the client site:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  client_options = {}
  client_options[:site] = 'https://test.myadventist.org' unless Rails.env.production?
  provider :myadventist, Rails.application.secrets.myadventist_client_key, Rails.application.secrets.myadventist_client_secret, client_options: client_options
end
```

A callback URL also needs to be added to routes.rb The route can point to any controller action of your choice.

```ruby
get '/auth/:provider/callback', to: 'sessions#create'
```

From your callback, authentication can take place.

```ruby
class SessionsController < ApplicationController

  def create
    if @user = User.from_omniauth( request.env['omniauth.auth'] )
      self.current_user = @user
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

end
```

The omniauth.auth object is available for the users info. Note that the uid provided by myAdventist is actually the access_token rather than the user ID. This uid will be different for different applications.

```ruby
#<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash expires=false token="1234-67890-5678-34567"> extra=#<OmniAuth::AuthHash> info=#<OmniAuth::AuthHash::InfoHash email="bobgoodman@email.com" first_name="Bob" last_name="Goodman" name="Bob Goodman"> provider="myadventist" uid="1234-67890-5678-34567">
```

In models/user.rb you can handle your authentication checking based on the uid and provider.

```ruby
class User < ApplicationRecord
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adventistmedia/omniauth-myadventist. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

