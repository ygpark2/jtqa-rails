module Api
  module V1
    class CsrfController < Api::BaseController

      def index
        render json: { request_forgery_protection_token => form_authenticity_token }.to_json
      end

    end
  end
end
