class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :navn
      t.text :beskrivelse

      t.timestamps
    end
  end
end
