module Api
  module V1
    class PostsController < Api::BaseController

      private

      def post_params
        params.require(:post).permit(:type, :name, :title, :email, :contact, :content)
      end

      def query_params
        params.permit(:name, :title)
      end

    end
  end
end
