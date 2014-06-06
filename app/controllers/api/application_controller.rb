class ApplicationController < ActionController::API

  attr_accessor :result, :user_info, :alg

  def initialize
    # setting initial value (optional)
    @result = {}
    @user_info = []
    @alg = "HS512"
  end

  protected

  def validate_token
    begin
      token = request.headers['Authorization'].split(' ').last
      @user_info = JWT.decode(token, Rails.application.config.jwt_salt, @alg)
      logger.debug "user info => " + @user_info.inspect
      if Time.at(@user_info.first['timestamp']) < 2.hours.ago
        render nothing: true, status: :unauthorized
      else
        @user_info.first['timestamp'] = Time.now.to_i
      end
    rescue JWT::DecodeError
      render nothing: true, status: :unauthorized
    end
  end

end
