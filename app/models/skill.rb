class Skill < ActiveRecord::Base
  has_many :member_skills
  has_many :members, through: :member_skills
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |skill|
        csv << skill.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Skill.create! row.to_hash
    end
  end
end