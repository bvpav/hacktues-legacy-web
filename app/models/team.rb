class Team < ActiveRecord::Base
  serialize :members_id, Array
  serialize :technologies, Array

  validates :name,  presence: true, length: { maximum: 50 }
  validates :project_desc,  presence: true, length: { minimum: 50, maximum: 500 }
  validates :technologies, length: { maximum: 10 }
  validates :members_id, length: { maximum: 4 }
end
