class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :name, limit: 128
      t.string :mime, limit: 64
      t.binary :data

      t.timestamps
    end
  end
end
