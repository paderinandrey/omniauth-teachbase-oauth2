# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Teachbase < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'teachbase'

      option :client_options,
             site: 'https://78.155.206.30:3000',
             authorize_url: '/oauth/authorize'
            # token_url: 'http://78.155.206.30:3000/oauth/token'

      uid { raw_info['id'] }

      info do
        {
          :email => raw_info["email"]
          # name: user_name,
          # email: raw_info['emailAddress'],
          # nickname: user_name,
          # first_name: raw_info['firstName'],
          # last_name: raw_info['lastName'],
          # location: raw_info['location'],
          # description: raw_info['headline'],
          # image: raw_info['pictureUrl'],
          # urls: {
          #   'public_profile' => raw_info['publicProfileUrl']
          # }
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      def callback_url
        binding.pry
        full_host + script_name + callback_path
      end

      alias oauth2_access_token access_token

      def access_token
        binding.pry
        ::OAuth2::AccessToken.new(client, oauth2_access_token.token,
                                  mode: :query,
                                  param_name: 'oauth2_access_token',
                                  expires_in: oauth2_access_token.expires_in,
                                  expires_at: oauth2_access_token.expires_at)
      end

      def raw_info
        binding.pry
        @raw_info ||= access_token.get('/api/v2/me.json').parsed
        # @raw_info ||= access_token.get("/v1/people/~:(#{option_fields.join(',')})?format=json").parsed
      end

      private

      # def option_fields
      #   fields = options.fields
      #   fields.map! { |f| f == "picture-url" ? "picture-url;secure=true" : f } if !!options[:secure_image_url]
      #   fields
      # end

      def user_name
        binding.pry
        # name = "#{raw_info['firstName']} #{raw_info['lastName']}".strip
        # name.empty? ? nil : name
      end
    end
  end
end

OmniAuth.config.add_camelization 'teachbase', 'Teachbase'
