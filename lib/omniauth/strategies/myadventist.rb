require 'omniauth/strategies/oauth2'
require 'uri'

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

      # def callback_phase # rubocop:disable AbcSize, CyclomaticComplexity, MethodLength, PerceivedComplexity
      #   error = request.params["error_reason"] || request.params["error"]
      #   if error
      #     fail!(error, CallbackError.new(request.params["error"], request.params["error_description"] || request.params["error_reason"], request.params["error_uri"]))
      #   elsif !options.provider_ignores_state && (request.params["state"].to_s.empty? || request.params["state"] != session.delete("omniauth.state"))
      #     fail!(:csrf_detected, CallbackError.new(:csrf_detected, "CSRF detected"))
      #   else
      #     self.access_token = build_access_token
      #     self.access_token = access_token.refresh! if access_token.expired?
      #     super
      #   end
      #   rescue ::OAuth2::Error, CallbackError => e
      #     fail!(:invalid_credentials, e)
      #   rescue ::Timeout::Error, ::Errno::ETIMEDOUT => e
      #     fail!(:timeout, e)
      #   rescue ::SocketError => e
      #     fail!(:failed_to_connect, e)
      # end


      def callback_url
        options[:callback_url] || (full_host + script_name + callback_path)
      end

      def build_access_token
        verifier = request.params["code"]
        # myAdventist doesn't accept params on redirect_uri which omniauth adds.
        client.auth_code.get_token(verifier, {"redirect_uri" => callback_url, "state" => request.params["state"]}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(options.auth_token_params))
      end

    end
  end
end