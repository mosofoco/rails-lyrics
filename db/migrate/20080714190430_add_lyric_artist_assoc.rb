class AddLyricArtistAssoc < ActiveRecord::Migration
  def self.up
    add_column :lyrics, :artist_id, :integer
  end

  def self.down
    remove_column :table_name, :column_name
  end
end
