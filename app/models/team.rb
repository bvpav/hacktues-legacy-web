class Team < ActiveRecord::Base
  serialize :members_id, Array
  serialize :technologies, Array

  validates :name,  presence: true, length: { maximum: 50 }
  validates :project_desc,  presence: true, length: { minimum: 50 }
end
