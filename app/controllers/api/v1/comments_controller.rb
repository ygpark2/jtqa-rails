module Api
  module V1
    class CommentsController < Api::BaseController

      private

      def post_params
        params.require(:comment).permit(:name, :title, :content)
      end

      def query_params
        params.permit(:name)
      end

    end
  end
end
