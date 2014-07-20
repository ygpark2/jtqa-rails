module Api
  module V1
    class MelbournesController < Api::BaseController

      private

      def melbourne_params
        params.require(:melbourne).permit(:category, :name, :title, :email, :contact, :content)
      end

      def query_params
        params.permit(:name, :title)
      end

    end
  end
end
