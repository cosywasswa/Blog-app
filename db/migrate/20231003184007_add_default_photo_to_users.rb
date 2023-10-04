class AddDefaultPhotoToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :photo, "https://drive.google.com/file/d/1Bn5NyWmV5Eo_WI7dq2nZYlMheA0kiDBh/view?usp=sharing"
  end
end
