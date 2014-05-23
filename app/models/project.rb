class Project < ActiveRecord::Base
	belongs_to :team
	has_many :member_projects
    has_many :members, through: :member_projects
end
