module Api
  module V1
    class SydneysController < Api::BaseController

      private

      def sydney_params
        params.require(:sydney).permit(:category, :name, :title, :email, :contact, :content)
      end

      def query_params
        params.permit(:name, :title)
      end

    end
  end
end
