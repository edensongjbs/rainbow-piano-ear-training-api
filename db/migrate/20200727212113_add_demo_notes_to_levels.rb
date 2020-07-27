class AddDemoNotesToLevels < ActiveRecord::Migration[6.0]
  def change
    add_column :levels, :demo_notes, :string
  end
end
