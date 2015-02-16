module Api
  module V1
    class CommentsController < Api::BaseController

      # POST /api/{plural_resource_name}/{plural_resource_name_id}/comments
      def create
        del_key_str = "Post"
        # rsc_key_nm = params.keys.find_all{|e| e.end_with?(del_key_str)}.first
        rsc_key_nm = params[:comment][:type]
        post_nm = rsc_key_nm.chomp! del_key_str
        post = post_nm.classify.constantize.find params[:comment][:post]
        logger.debug(post)
        logger.debug("---------------------------------")
        logger.debug(params.values)
        logger.debug(params.keys.find_all{|e| e.end_with?("_id")})
        logger.debug(resource_class)
        logger.debug(resource_name)
        logger.debug("---------------------------------")
        # set_resource(resource_class.new(resource_params))

        comment = post.comments.create
        comment.title = params[:title]
        comment.comment = params[:comment]
        if post.save
          logger.debug("++++++++++++++++++++++++++")
          logger.debug(post.comments.inspect)
          logger.debug("++++++++++++++++++++++++++")
          render json: {post_nm => post}, status: :created
        else
          # render json: get_resource.errors, status: :unprocessable_entity
        end
      end

      # GET /api/{plural_resource_name}/{plural_resource_name_id}/comments
      def index
        rsc_key_nm = params.keys.find_all{|e| e.end_with?("_id")}.first
        post_nm = rsc_key_nm.split("_").first
        post = post_nm.classify.constantize.find params[rsc_key_nm]
        comments = post.comments.to_a

        logger.debug "brisbanes => #{post.inspect}"
        logger.debug "brisbanes name => #{post_nm}"
        logger.debug "brisbanes comments => #{post.comments.inspect}"
        logger.debug "resource_name => #{resource_name.pluralize}"
        logger.debug "comments => #{comments.inspect}"

        render json: {resource_name.pluralize => post.comments}, status: 200
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
