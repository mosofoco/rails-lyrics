class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums, :force => true do |t|
      t.column :title, :string
      t.column :year, :integer
      t.column :artist_id, :integer
    end
  end

  def self.down
    drop_table :albums
  end
end
