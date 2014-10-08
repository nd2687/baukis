# == Schema Information
#
# Table name: addresses
#
#  id            :integer          not null, primary key
#  customer_id   :integer          not null
#  type          :string(255)      not null
#  postal_code   :string(255)      not null
#  prefecture    :string(255)      not null
#  city          :string(255)      not null
#  address1      :string(255)      not null
#  address2      :string(255)      not null
#  company_name  :string(255)      default(""), not null
#  division_name :string(255)      default(""), not null
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_addresses_on_city                          (city)
#  index_addresses_on_customer_id                   (customer_id)
#  index_addresses_on_postal_code                   (postal_code)
#  index_addresses_on_prefecture_and_city           (prefecture,city)
#  index_addresses_on_type_and_city                 (type,city)
#  index_addresses_on_type_and_customer_id          (type,customer_id) UNIQUE
#  index_addresses_on_type_and_prefecture_and_city  (type,prefecture,city)
#

FactoryGirl.define do
  factory :home_address do
    postal_code '1000000'
    prefecture '東京都'
    city '千代田区'
    address1 '試験1-1-1'
    address2 ''
  end

  factory :work_address do
    company_name 'テスト'
    division_name '開発部'
    postal_code '1040000'
    prefecture '東京都'
    city '港区'
    address1 '試験1-03'
    address2 ''
  end
end
