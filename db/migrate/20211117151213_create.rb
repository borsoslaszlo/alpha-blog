class Create < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.datetime :created_at
      t.datetime :modified_at
  end
  end
end
