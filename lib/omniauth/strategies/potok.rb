# frozen_string_literal: true

require 'omniauth'
require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Potok < ::OmniAuth::Strategies::OAuth2
      AUTHORIZE_PATH = '/api/v3/oauth/authorize'
      TOKEN_PATH = '/api/v3/oauth/token'
      ME_PATH = '/api/v3/me'

      option :name, 'potok'
      option :client_options, {
        site: 'https://app.potok.io',
        authorize_url: AUTHORIZE_PATH,
        token_url: TOKEN_PATH
      }

      uid { raw_info['id'] }

      info do
        {
          company_id: raw_info.dig('company_id'),
          email: raw_info.dig('email')
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get(ME_PATH).parsed
      end
    end
  end
end
