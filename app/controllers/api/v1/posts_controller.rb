module Api
  module V1
    class PostsController < Api::BaseController

      private

      def post_params
        params.require(:post).permit(:name, :title, :content)
      end

      def query_params
        params.permit(:name)
      end

    end
  end
end
