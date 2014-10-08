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

require 'rails_helper'

describe Administrator do
  describe '#password=' do
    example '文字列を与えると、hashed_passwordは長さ60の文字列になる' do
      admin = Administrator.new
      admin.password = 'baukis'
      expect(admin.hashed_password).to be_kind_of(String)
      expect(admin.hashed_password.size).to eq(60)
    end

    example 'nilを与えると、hashed_passwordはnilになる' do
      admin = Administrator.new(hashed_password: 'x')
      admin.password = nil
      expect(admin.hashed_password).to be_nil
    end
  end
end
