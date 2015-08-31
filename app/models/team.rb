class Team < ActiveRecord::Base
  serialize :members_id, Array
  serialize :technologies, Array

  validates :name,  presence: true
end
