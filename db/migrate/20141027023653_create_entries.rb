class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :url
      t.datetime :date
      t.integer :author_id
    end
  end
end
