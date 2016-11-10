require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class Myadventist < OmniAuth::Strategies::OAuth
      option :name, 'myadventist'
      option :client_options, {
        authorize_path: '/oauth/authorize',
        site: 'https://test.myadventist.org.au',
      }

      uid { access_token.params[:user_id] }
    end
  end
end