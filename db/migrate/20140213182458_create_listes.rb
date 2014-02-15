class CreateListes < ActiveRecord::Migration
  def change
    create_table :listes do |t|
      t.string :navn
      t.string :bane
      t.text :beskrivelse

      t.timestamps
    end
  end
end
