module Api
  module V1
    module User

      class RegistrationsController < Devise::RegistrationsController

        def create
          build_resource devise_parameter_sanitizer.sanitize(:sign_up)
          respond_to do |format|
            format.html { super }
            format.json do

              if resource.save
                if resource.active_for_authentication?
                  render json: {success: true}
                else
                  expire_session_data_after_sign_in!
                  render json: {success: true}
                end
              else
                clean_up_passwords resource
                render json: {success: false}
              end

            end
          end
        end

        private

        def user_params
          params.require(:user).permit(:first_name, :last_name, :contact_number)
        end
      end

    end
  end
end
