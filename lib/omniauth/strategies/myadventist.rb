require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Myadventist < OmniAuth::Strategies::OAuth2

      option :name, 'myadventist'
      option :client_options, {
        site: 'https://test.myadventist.org.au',
        authorize_url: 'https://test.myadventist.org.au/oauth/authorize',
        token_url: 'https://test.myadventist.org.au/oauth/gettoken'
      }

      uid { access_token.params[:user_id] }
    end
  end
end