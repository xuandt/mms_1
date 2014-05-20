class Team < ActiveRecord::Base
	has_many :projects, dependent: :destroy
end
