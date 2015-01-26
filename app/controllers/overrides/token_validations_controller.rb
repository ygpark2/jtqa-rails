module Overrides
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController

    def validate_token
      # @resource will have been set by set_user_token concern
      if @resource
        render json: {
            success: true,
            data: @resource.as_json(except: [
            :tokens, :created_at, :updated_at
        ])
        }
      else
        render json: {
            success: false,
            errors: ["Invalid login credentials"]
        }, status: 401
      end
    end

    def validate_token
      # @user will have been set by set_user_by_token concern
      if @user
        render json: {
            data: @user.as_json(methods: :calculate_operating_thetan)
        }
      else
        render json: {
            success: false,
            errors: ["Invalid login credentials"]
        }, status: 401
      end
    end
  end
end