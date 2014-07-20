module Api
  module V1
    class BrisbanesController < Api::BaseController

      private

      def brisbane_params
        params.require(:brisbane).permit(:category, :name, :title, :email, :contact, :content)
      end

      def query_params
        params.permit(:name, :title)
      end

    end
  end
end
