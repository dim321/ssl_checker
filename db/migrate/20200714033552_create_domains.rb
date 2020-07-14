class CreateDomains < ActiveRecord::Migration[6.0]
  def change
    create_table :domains do |t|
      t.string :name
      t.boolean :status

      t.timestamps
    end
    add_index :domains, :name, unique: true
    add_index :domains, :status
  end
end
