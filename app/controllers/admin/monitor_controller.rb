class Admin::MonitorController < ApplicationController
  def index
    @models = []
    ActiveRecord::Base.connection.tables.each do |table|
      @models << table.camelize.singularize
    end
  end

  def export
    model = params[:model]
    respond_to do |format|
      format.csv { send_data export_csv(model), filename: "#{model}.csv" }
    end
  end

  def import
    model = params[:model]
    if params[:file].present?
      import_csv(model, params[:file])
      flash[:success] = "#{model} imported!"
    else
      flash[:error] = "Chosen file to import!"
    end
    redirect_to :back
  end

  def export_csv model
    CSV.generate do |csv|
      csv << model.constantize.column_names
      model.constantize.all.each do |data|
        csv << data.attributes.values_at(*model.constantize.column_names)
      end
    end
  end

  def import_csv model, file
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash
      record = model.constantize.where id: row[0]
      model.constantize.create row_hash if record.count == 0
    end
  end
  
end