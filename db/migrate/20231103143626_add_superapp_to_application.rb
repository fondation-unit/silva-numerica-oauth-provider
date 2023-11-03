class AddSuperappToApplication < ActiveRecord::Migration[7.1]
  def change
    add_column :oauth_applications, :superapp, :boolean, null: false, default: false
  end
end
