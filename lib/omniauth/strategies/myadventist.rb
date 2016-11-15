require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Myadventist < OmniAuth::Strategies::OAuth2

      option :name, 'myadventist'
      option :client_options, {
        site: 'https://test.myadventist.org.au',
        authorize_url: '/oauth/authorize',
        token_url: '/oauth/gettoken'
      }

      uid { access_token.token }

      info do
        {
          'email' => raw_info['PrimaryEmail'],
          'name' => "#{raw_info['FirstName']} #{raw_info['LastName']}",
          'first_name' => raw_info['FirstName'],
          'last_name' => raw_info['LastName']
        }
      end

      def raw_info
        @raw_info ||= access_token.post('https://test.myadventist.org.au/oauth/userinfo', params: raw_info_params).parsed || {}
      end

      def raw_info_params
        {
          redirect_uri: callback_url,
          state: SecureRandom.hex(10),
          access_token: access_token.token,
          client_id: client.id
        }
      end

      def callback_url
        options[:callback_url] || (full_host + script_name + callback_path)
      end

    end
  end
end