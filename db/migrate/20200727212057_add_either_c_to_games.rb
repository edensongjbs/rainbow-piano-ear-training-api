class AddEitherCToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :either_c, :boolean, default: false
  end
end
