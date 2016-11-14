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

      uid { raw_info['uid'] }

      info do
        {
          'email' => raw_info['PrimaryEmail'],
          'first_name' => raw_info['FirstName'],
          'last_name' => raw_info['LastName']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://test.myadventist.org.au/oauth/userinfo').parsed
      end


      def callback_url
        full_host + script_name + callback_path
      end

      # def build_access_token
      #   verifier = request.params["code"]
      #   # myAdventist doesn't accept params on redirect_uri which omniauth adds.
      #   client.auth_code.get_token(verifier, {"redirect_uri" => callback_url, "state" => request.params["state"]}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(options.auth_token_params))
      # end

    end
  end
end