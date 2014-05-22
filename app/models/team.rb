class Team < ActiveRecord::Base
	has_many :projects, dependent: :destroy
	has_many :members, dependent: :destroy
end
