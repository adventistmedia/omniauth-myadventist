require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class Myadventist < OmniAuth::Strategies::OAuth
      option :name, 'myadventist'
      option :client_options, {
        site: 'https://test.myadventist.org.au',
        authorize_path: '/oauth/authorize',
        token_url: '/oauth/gettoken'
      }

      uid { access_token.params[:user_id] }
    end
  end
end