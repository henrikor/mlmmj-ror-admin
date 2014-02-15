class CreateJoinTableGroupListe < ActiveRecord::Migration
  def change
    create_join_table :groups, :listes do |t|
      # t.index [:group_id, :liste_id]
      # t.index [:liste_id, :group_id]
    end
  end
end
