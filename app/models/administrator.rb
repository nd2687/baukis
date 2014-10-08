# == Schema Information
#
# Table name: administrators
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  email_for_index :string(255)      not null
#  hashed_password :string(255)
#  suspended       :boolean          default(FALSE), not null
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_administrators_on_email_for_index  (email_for_index) UNIQUE
#

class Administrator < ActiveRecord::Base
  include EmailHolder
  include PasswordHolder
end
