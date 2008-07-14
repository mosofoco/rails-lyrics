class CreateLyrics < ActiveRecord::Migration
  def self.up
    create_table :lyrics, :force => true do |t|
      t.column :title, :string
      t.column :album, :string
      t.column :year, :integer
      t.column :track, :integer
      t.column :genre, :string
      t.column :body, :text
    end
  end

  def self.down
    drop_table :lyrics
  end
end
