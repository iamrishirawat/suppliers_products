class CreateMappings < ActiveRecord::Migration[5.1]
  def change
    create_table :mappings do |t|
      t.references :supplier, foreign_key: true
      t.references :product, foreign_key: true
      t.boolean :is_active

      t.timestamps
    end
  end
end
