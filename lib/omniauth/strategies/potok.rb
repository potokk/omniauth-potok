# frozen_string_literal: true

require 'omniauth'
require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Potok < ::OmniAuth::Strategies::OAuth2
      option :name, 'potok'
      option :client_options, {
        site: 'https://app.potok.io/api/v4',
        authorize_url: 'https://app.potok.io/api/v4/oauth/authorize'
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
        @raw_info ||= access_token.get('me').parsed
      end
    end
  end
end
