module Api
  module V1
    class CommentsController < Api::BaseController

      # POST /api/{plural_resource_name}/{plural_resource_name_id}/comments
      def create
        del_key_str = "Post"
        rsc_key_nm = params[:comment][:type]
        @resource_name = rsc_key_nm.chomp! del_key_str
        obj = resource_class.find params[:comment][:id]
        # set_resource(resource_class.new(resource_params))

        comment = obj.comments.create(title: params[:comment][:title], comment: params[:comment][:comment])
        obj.total_comments = obj.total_comments + 1 # increase comment count
        if obj.save
          render json: {@resource_name => obj}, status: :created
        else
          # render json: get_resource.errors, status: :unprocessable_entity
        end
      end

      # GET /api/{plural_resource_name}/{plural_resource_name_id}/comments
      def index
        @resource_name = params[:klass].singularize
        obj = resource_class.find params[:id]
        render json: {self.controller_name.pluralize => obj.comments}, status: 200
        # respond_with resource_name.pluralize => comments
      end

      private

      def post_params
        params.require(:comment).permit(:user_id, :title, :comment)
      end

      def query_params
        params.permit(:title)
      end

    end
  end
end
