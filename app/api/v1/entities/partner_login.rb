module Entities
  class PartnerLogin < Grape::Entity
    # TODO: in case some attributes are null, what are returned?
    expose :id
    expose :access_token

    private

      def id
        object.id.present? ? object.id : 0
      end

      def access_token
        object.access_token
      end

    end
  end
