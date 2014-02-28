class CreateChanges < ActiveRecord::Migration
  def change
    create_table :changes do |t|
      t.integer :user_id
      t.integer :list_id
      t.text :added_adresses
      t.text :removed_adresses

      t.timestamps
    end
  end
end
