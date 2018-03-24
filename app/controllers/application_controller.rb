class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def help
    render 'layouts/_help'
  end

  def tree
    render 'layouts/_tree'
  end
end

