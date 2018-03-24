class SalariesController < ApplicationController


  def edit
  end

  def update
    @salary = Salary.find(params[:id])
    @salary.update salary_params
    redirect_to :back
  end

  private

  def salary_params
    params.require(:salary).permit(:salary)
  end

end
