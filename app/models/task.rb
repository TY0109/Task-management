class Task < ApplicationRecord
  belongs_to :user, optional: :true
  
  validates :name, presence:true, length:{maximum:50}
  validates :description, presence:true, length:{minimum:5}
end
