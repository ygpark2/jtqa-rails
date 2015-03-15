module Api
  class BaseController < ApplicationController

    protect_from_forgery with: :null_session

    before_action :set_resource, only: [:destroy, :show, :update]
    # skip_before_filter  :verify_authenticity_token
    before_action :authenticate_user!, only: [:create]

    respond_to :json

    # POST /api/{plural_resource_name}
    def create
      set_resource(get_resource_class.new(get_resource_params))

      if get_resource.save
        # respond_with resource_name => get_resource, status: :created
        render json: {get_resource_name => get_resource}, status: :created
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/{plural_resource_name}/1
    def destroy
      get_resource.destroy
      head :no_content
    end

    # GET /api/{plural_resource_name}
    def index
      plural_resource_name = "@#{get_resource_name.pluralize}"
      order = {"created_at" => :desc}
      resources = get_resource_class.where(query_params).order(order).page(page_params[:page]).per(page_params[:per_page])

      instance_variable_set(plural_resource_name, resources)
      logger.debug("rsc name => " + plural_resource_name)
      logger.debug("inst var => " + instance_variable_get(plural_resource_name).inspect)
      respond_with resource_name.pluralize => instance_variable_get(plural_resource_name)
    end

    # GET /api/{plural_resource_name}/1
    def show
      rsc = get_resource
      if rsc.has_attribute? "views"
        if rsc.update({:views => rsc[:views] + 1})
          respond_with get_resource_name => rsc, status: 200
        else
          render json: rsc.errors, status: :unprocessable_entity
        end
      else
        respond_with get_resource_name => rsc, status: 200
      end

    end

    # PATCH/PUT /api/{plural_resource_name}/1
    def update
      if get_resource.update(get_resource_params)
        respond_with get_resource_name => get_resource, status: 200
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    end

    private

    # Returns the resource from the created instance variable
    # @return [Object]
    def get_resource
      instance_variable_get("@#{get_resource_name}")
    end

    # Returns the allowed parameters for searching
    # Override this method in each API controller
    # to permit additional parameters to search on
    # @return [Hash]
    def query_params
      {}
    end

    # Returns the allowed parameters for pagination
    # @return [Hash]
    def page_params
      params.permit(:page, :per_page)
    end

    # The resource class based on the controller
    # @return [Class]
    def get_resource_class
      @resource_class ||= resource_name.classify.constantize
    end

    # The singular name for the resource class based on the controller
    # @return [String]
    def get_resource_name
      @resource_name ||= self.controller_name.singularize
    end

    # Only allow a trusted parameter "white list" through.
    # If a single resource is loaded for #create or #update,
    # then the controller for the resource must implement
    # the method "#{resource_name}_params" to limit permitted
    # parameters for the individual model.
    def get_resource_params
      @resource_params ||= self.send("#{resource_name}_params")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_resource(resource = nil)
      resource ||= resource_class.find(params[:id])
      instance_variable_set("@#{resource_name}", resource)
    end
  end
end
