class AddCommentsToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_comment(:users, :nickname,            'ニックネーム')
    change_column_comment(:users, :email,               'メールアドレス')
    change_column_comment(:users, :encrypted_password,  'パスワード')
    change_column_comment(:users, :last_name,           '苗字')
    change_column_comment(:users, :first_name,          '名前')
    change_column_comment(:users, :furi_last_name,      'みょうじ')
    change_column_comment(:users, :furi_first_name,     'なまえ')
    change_column_comment(:users, :date_of_birth,       '生年月日')
  end
end
