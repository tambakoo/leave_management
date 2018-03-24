class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :leaves, dependent: :destroy
  # has_many :employee_managements, class_name: 'Management', 
  #                                 # foreign_key: 'manager_id', dependent: :destroy
  # has_many :employees, through: :employee_managements

  # has_one :manager_management, class_name: 'Management', 
  #                                 foreign_key: 'employee_id', dependent: :destroy
  # has_one :manager, through: :manager_management
  has_one :leave_record, dependent: :destroy

  has_many :employees, class_name: "User",
                        foreign_key: "manager_id"
 
  belongs_to :manager, class_name: "User", required: false

  has_one :salary, dependent: :destroy

  after_create :create_leave_record, :create_salary

  def manager?
    employees.present?
  end

  def leave_manager?(leave)
    leave.user.manager==current_user
  end

  def create_leave_record
    LeaveRecord.create(user: User.last, leaves_remaining: 0, leaves_allotted: 0)    
  end

  def create_salary
    Salary.create(user: User.last, salary: 1)    
  end

  def self.is_manager?(employee,manager)
    employee.manager == manager
  end


end
