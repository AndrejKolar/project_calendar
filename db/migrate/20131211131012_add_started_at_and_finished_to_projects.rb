class AddStartedAtAndFinishedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :started_at, :datetime
    add_column :projects, :finished_at, :datetime
    add_column :projects, :finished, :boolean
  end
end
