class CreateBeehives < ActiveRecord::Migration[7.1]
  def change
    create_table :beehives do |t|
      t.string :name
      t.integer :weight

      t.timestamps
    end
  end
end
