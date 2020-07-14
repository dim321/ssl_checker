class CreateStatusEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :status_events do |t|
      t.string :message
      t.references :domain, null: false, foreign_key: true

      t.timestamps
    end
    add_index :status_events, :message
  end
end
