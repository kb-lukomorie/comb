class CreateGenerators < ActiveRecord::Migration
  def change
    create_table :generators do |t|
      t.string :name
      t.text :words

      t.timestamps
    end
  end
end
