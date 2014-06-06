require 'jwt'

module Api
  module V1
    class UsersController < ApplicationController

      before_action :validate_token, except: [:login]

      def login
        user = User.select(:id, :email, :password_hash, :type, :country_id).find_by_email(params[:username])
        if user.nil?
          @result = {success: false, message: "invalid email address", access_token: ""}
        else
          if user.password == params[:password]
            user_hash = user.attributes
            user_hash.delete(:password_hash)
            user_hash['lang'] = params[:lang].nil? ? "en" : params[:lang]
            user_hash['timestamp'] = Time.now.to_i
            @result = {success: true, message: "login success!", access_token: JWT.encode(user_hash, Rails.application.config.jwt_salt, @alg)}
          else
            @result = {success: false, message: "invalid password!", access_token: ""}
          end
        end
        render json: @result
      end

      def reset_password
        user = User.find_by_email(@user_info.first['email'])
        if user.nil?
          @result = {success: false, message: "user not found", access_token: ""}
        else
          if user.password == params[:old_password]
            user.password = params[:new_password]
            user.unblock
            # user.password_reset_required = true
            user.save!
            @result = {success: true, message: "password changed", access_token: JWT.encode(@user_info.first, Rails.application.config.jwt_salt, @alg)}
          else
            @result = {success: false, message: "invalid password!", access_token: ""}
          end
        end
        render json: @result
      end

      def profile
        user = User.select(:email, :last_name, :first_name, :address, :contact_number, :city).find_by_email(@user_info.first['email'])
        if user.nil?
          @result = {success: false, message: "user not found", access_token: ""}
        else
          @result = {success: true, message: "user found", user: user, access_token: JWT.encode(@user_info.first, Rails.application.config.jwt_salt, @alg)}
        end
        render json: @result
      end

    end
  end
end
