class CreateChapters < ActiveRecord::Migration[5.1]
  def change
    create_table :chapters do |t|
      t.string :title, limit: 128
      t.string :author, limit: 32
      t.text :description

      t.timestamps
    end
  end
end
