class LeaveRecordsController < ApplicationController
  after_action :update_remaining_leaves, only: [:update]


  def edit
  end

  def update
    @leave_record = LeaveRecord.find(params[:id])
    @delta = update_params[:leaves_allotted].to_i - @leave_record.leaves_allotted
    @leave_record.update update_params
    redirect_to :back
  end

  private

  def update_params
    params.require(:leave_record).permit(:leaves_allotted)
  end

  def update_remaining_leaves
    @leave_record.update_attributes(leaves_remaining: @leave_record.leaves_remaining+@delta)
  end

end
