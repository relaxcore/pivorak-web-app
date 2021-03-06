# frozen_string_literal: true

module Courses
  class BaseController < ApplicationController
    before_action :authenticate_user!

    helper_method :current_season, :current_student

    def current_season
      @current_season ||= ::Courses::Season
                          .friendly
                          .find(params[:season_id] ||= params[:id])
    end

    def current_student
      @current_student ||= current_season.students.find_by(user_id: current_user.id)
    end

    private

    def render_form
      render :form
    end

    def react_to(action)
      if action
        flash_success && default_redirect
      else
        flash_error && render_form
      end
    end
  end
end
