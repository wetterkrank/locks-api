class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.datetime :timestamp
      t.string :status_change
      t.references :lock, null: false, foreign_key: true, type: :string

      t.timestamps
    end
  end
end
