class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :state,  null: false, limit: 5
      t.string :name,   null: false, limit: 60
      t.string :email,  null: false, limit: 80
      t.string :phone,  null: false, limit: 15

      t.timestamps
    end
    add_index :participants, :state
  end
end
