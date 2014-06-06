module Api
  module V1
    class GamesController < ApplicationController

      before_action :validate_token

      def history
        page_size = 10
        start_time = Time.now - 60 * 60 * 24 * 7
        end_time = Time.now + 60 * 60 * 24 * 2
        # start_time = Time.parse(params[:start_time])
        # end_time = Time.parse(params[:end_time])
        transactions, total = Interaction.player_transactions(@user_info.first['email'], start_time, end_time, params[:page], page_size)
        if total > 0
          @result = {success: false, message: "transaction records", transactions: transactions, total: total, access_token: JWT.encode(@user_info.first, Rails.application.config.jwt_salt, @alg)}
        else
          @result = {success: true, message: "no transactions", access_token: ""}
        end
        render json: @result
      end

    end
  end
end
