# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # Teachbase OAuth2 Strategy for OmniAuth
    class Teachbase < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'teachbase'

      option :client_options,
             site: 'https://go.teachbase.ru',
             authorize_url: '/oauth/authorize',
             token_url: '/oauth/token'

      uid { raw_info['id'] }

      info do
        {
          email: raw_info['email'],
          phone: raw_info['phone'],
          name: user_name,
          first_name: raw_info['first_name'],
          last_name: raw_info['last_name'],
          lang: raw_info['lang'],
          notice_email: raw_info['notice_email'],
          avatar_url: raw_info['avatar_url'],
          accounts: raw_info['accounts']
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      def callback_url
        options[:callback_url] || (full_host + script_name + callback_path)
      end

      def raw_info
        @raw_info ||= access_token.get('/mobile/v1/profile').parsed
      end

      private

      def user_name
        name = "#{raw_info['first_name']} #{raw_info['last_name']}".strip
        name.empty? ? nil : name
      end
    end
  end
end

OmniAuth.config.add_camelization 'teachbase', 'Teachbase'
