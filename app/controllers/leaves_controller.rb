class LeavesController < ApplicationController
  before_action :find_leave, only: [:destroy, :update]

  def index
    if params[:mgr]
      @employees = current_user.employees
      leaves = current_user.employees.map(&:leaves).flatten
      @active_leaves = leaves.select {|x| x.start_date > Time.zone.now}
    else
      @active_leaves = current_user.leaves.active.order(start_date: :asc)
      @inactive_leaves = current_user.leaves.where("start_date < ?", Time.zone.now)
    end
  end

  def create 
    @leave = current_user.leaves.new(leave_params)
    if @leave.correct_dates? && @leave.correct_size?
       @leave.update_attributes(state: 0) 
       @leave.save 
       flash[:alert] = "Leave requested. Wait for approval"
       redirect_to :leaves
       pre = @leave.user.leave_record.leaves_remaining 
       delta = @leave.duration.to_i
       @leave.user.leave_record.update leaves_remaining: pre-delta
    else
      flash[:alert] = "Invalid dates. You can only apply for a leave in the future, equal or less than remaining leaves."
      redirect_to :back
    end
  end

  def destroy
    pre = @leave.user.leave_record.leaves_remaining 
    delta = @leave.duration.to_i
    @leave.destroy
    @leave.user.leave_record.update leaves_remaining: pre+delta unless @leave.state.eql?("rejected")
    flash[:alert] = "Request cancelled"
    redirect_to :leaves
  end

  def new
    @leave= current_user.leaves.new
  end

  def show
  end

  def update
    pre = @leave.user.leave_record.leaves_remaining 
    delta = @leave.duration.to_i
    if params[:leave][:state].eql?("rejected")  
      @leave.user.leave_record.update leaves_remaining: pre+delta 
    elsif @leave.state.eql?("rejected") && params[:leave][:state].eql?("approved")  
      @leave.user.leave_record.update leaves_remaining: pre-delta 
    end
    @leave.update update_params
    redirect_to :back
  end

  def employee_records
    if params[:noquery].present?
    @employees = current_user.employees.all
    elsif
    @employees = [User.where(id: params[:user_id])].flatten
    @state = params[:state]
    end      
  end

  private


  def leave_params
    params.require(:leave).permit(:start_date, :end_date, :state)
  end

  def find_leave
    @leave= Leave.find(params[:id])
  end

  def update_params
    params.require(:leave).permit(:state)
  end
end
