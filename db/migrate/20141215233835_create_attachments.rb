class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.binary :file

      t.timestamps
    end
  end
end
