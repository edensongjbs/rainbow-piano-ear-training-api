class CreateUserLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :user_levels do |t|
      t.boolean :completed, default: false
      t.integer :best_score, default: 0
      t.integer :level_id
      t.integer :user_id

      t.timestamps
    end
  end
end
