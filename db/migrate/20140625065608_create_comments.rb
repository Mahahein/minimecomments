class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :user
      t.text :message
      t.datetime :time_sent
      t.boolean :isFixed

      t.timestamps
    end
  end
end
