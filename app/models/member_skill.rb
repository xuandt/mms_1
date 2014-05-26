class MemberSkill < ActiveRecord::Base
	attr_accessor :checked
    belongs_to :member
    belongs_to :skill
end
