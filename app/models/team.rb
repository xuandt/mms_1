class Team < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  has_many :members, dependent: :destroy
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |team|
        csv << team.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Team.create! row.to_hash
    end
  end
end
