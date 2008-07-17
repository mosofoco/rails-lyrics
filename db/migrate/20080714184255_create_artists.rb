class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists, :force => true do |t|
      t.column :name, :string
      t.column :genre, :string
      t.column :website, :string
      t.column :label, :string
      t.column :members, :text
    end

    add_column :lyrics, :artist_id, :integer

  end

  def self.down
    drop_table :artists
    remove_column :table_name, :column_name
  end
end
