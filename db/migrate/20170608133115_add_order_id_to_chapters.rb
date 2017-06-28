class AddOrderIdToChapters < ActiveRecord::Migration[5.1]
  def change
    add_column :chapters, :order_id, :integer, null: false, default: 0

    # order_id が not null かつ unique な値を代入してからユニークインデックスを作成する

    Chapter.find_each do |chapter|
      chapter.update_columns order_id: chapter.id
    end

    add_index :chapters, :order_id, unique: true
  end
end
