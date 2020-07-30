class UserLevelsController < ApplicationController
    def update
        byebug
        user_level = UserLevel.find(params[:id])
        user_level.update_attributes(user_level_params)
        byebug
        render json: user_level
    end

    private

    def user_level_params
        params.require(:user_level).permit(:best_score, :completed)
    end
end
