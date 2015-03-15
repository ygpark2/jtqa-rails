module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController

    def create
      # honor devise configuration for case_insensitive_keys
      if resource_class.case_insensitive_keys.include?(:email)
        email = resource_params[:email].downcase
      else
        email = resource_params[:email]
      end

      q = "uid = ? AND provider='email'"

      if ActiveRecord::Base.connection.adapter_name.downcase.starts_with? 'mysql'
        q = "BINARY uid = ? AND provider='email'"
      end

      @resource = resource_class.where(q, email).first

      if @resource and valid_params? and @resource.valid_password?(resource_params[:password]) and @resource.confirmed?
        # create client id
        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @resource.tokens[@client_id] = {
            token: BCrypt::Password.create(@token),
            expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
        }
        @resource.save

        sign_in(:user, @resource, store: false, bypass: false)

        logger.debug "----------------------------------------------------------"
        logger.debug @resource.tokens.inspect
        logger.debug "----------------------------------------------------------"
        render json: {
	        id: @resource.id,
          token: @resource.tokens[@client_id][:token],
          email: @resource.email
          # data: @resource.as_json(except: [
          #   :id, :email, :name, :nickname, :image, :uid, :created_at, :updated_at
          # ])
        }

      elsif @resource and not @resource.confirmed?
        render json: {
            success: false,
            errors: [
            "A confirmation email was sent to your account at #{@resource.email}. "+
                "You must follow the instructions in the email before your account "+
                "can be activated"
        ]
        }, status: 401

      else
        render json: {
            errors: ["Invalid login credentials. Please try again."]
        }, status: 401
      end
    end

  end

end
