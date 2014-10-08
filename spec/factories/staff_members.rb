# == Schema Information
#
# Table name: staff_members
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null
#  email_for_index  :string(255)      not null
#  family_name      :string(255)      not null
#  given_name       :string(255)      not null
#  family_name_kana :string(255)      not null
#  given_name_kana  :string(255)      not null
#  hashed_password  :string(255)
#  start_date       :date             not null
#  end_date         :date
#  suspended        :boolean          default(FALSE), not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_staff_members_on_email_for_index                       (email_for_index) UNIQUE
#  index_staff_members_on_family_name_kana_and_given_name_kana  (family_name_kana,given_name_kana)
#

FactoryGirl.define do
  factory :staff_member do
    sequence(:email) { |n| "member#{n}@example.com" }
    family_name '山田'
    given_name '太郎'
    family_name_kana 'ヤマダ'
    given_name_kana 'タロウ'
    password 'pw'
    start_date { Date.yesterday }
    end_date nil
    suspended false
  end
end
