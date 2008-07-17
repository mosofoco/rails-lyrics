class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums, :force => true do |t|
      t.column :title, :string
      t.column :year, :integer
      t.column :artist_id, :integer
    end
    
    add_column :lyrics, :album_id, :integer
    
  end

  def self.down
    remove_column :lyrics, :album_id
    drop_table :albums
  end
end
