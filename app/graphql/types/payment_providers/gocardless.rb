# frozen_string_literal: true

module Types
  module PaymentProviders
    class Gocardless < Types::BaseObject
      graphql_name 'GocardlessProvider'

      field :id, ID, null: false
      field :has_access_token, Boolean, null: false
      field :webhook_secret, String, null: true

      # NOTE: Access token is a sensitive information. It should not be sent back to the
      #       front end application
      def has_access_token
        object.access_token.present?
      end
    end
  end
end
