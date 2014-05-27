class Project < ActiveRecord::Base
  belongs_to :team
  has_many :member_projects
  has_many :members, through: :member_projects
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |project|
        csv << project.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Project.create! row.to_hash
    end
  end
end
