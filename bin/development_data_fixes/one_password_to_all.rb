password = User.first.password_digest
User.update_all password_digest: password
