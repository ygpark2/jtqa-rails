module Api
  module V1
    class ParticipantsController < Api::BaseController

      private

      def participant_params
        params.require(:participant).permit(:name, :email, :phone, :state)
      end

      def query_params
        params.permit(:name)
      end

    end
  end
end
