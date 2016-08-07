class AddUserIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, #table 
              :user_id, #column name
              :integer #type
  end
end
