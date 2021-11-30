class AddUserIdToArticle < ActiveRecord::Migration[6.1]
  def change
    add_col :articles, :user_id, :int
  end
end
