class CreateLocks < ActiveRecord::Migration[6.0]
  def change
    create_table :locks do |t|
      t.string :extra_id
      t.string :kind

      t.timestamps
    end
  end
end
