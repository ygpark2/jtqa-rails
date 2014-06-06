class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :state
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
