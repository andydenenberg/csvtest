# require 'fastercsv'
require 'csv'

class CsvController < ApplicationController
  def import
  end

#def upload
#    # While under development, just respond by rendering some in-line text.
#    # Send back the request parameters in JSON (JavaScript Object Notation)
#    # format, i.e. something reasonably easy to parse with the human eye.
#    render :text => params.to_json
#  end
#end

  def upload
    table = ImportTable.new :original_path => params[:upload][:csv].original_filename
    row_index = 0
    data = params[:upload][:csv].read # adding this line fixes undefined method `pos'
    CSV.parse(data) do |cells|
#   FasterCSV.parse(params[:upload][:csv]) do |cells|
      column_index = 0
      cells.each do |cell|
        table.import_cells.build :column_index => column_index, :row_index => row_index, :contents => cell
        column_index += 1
      end
      row_index += 1
    end
    table.save
    redirect_to import_table_path(table)
  end
end
