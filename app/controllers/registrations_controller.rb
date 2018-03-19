# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_action :find_manager, only: :create
  after_action :associate_manager,only: :create

  private
  def find_manager
    if params[:manager][:manager_id].blank?
      flash[:alert] = "You must select a manager"
      return redirect_to :back
    end
  end

  def associate_manager
    return if params[:manager][:manager_id].blank?
    @user.manager_id = params[:manager][:manager_id]
    @user.save
  end

end 



