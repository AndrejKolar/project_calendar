class AddTotalHoursToEvent < ActiveRecord::Migration
  def change
    add_column :events, :total_hours, :integer
  end
end
