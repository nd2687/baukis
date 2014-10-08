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

class StaffMember < ActiveRecord::Base
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  validates :end_date, date: {
    after: :start_date,
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }

  def active?
    !suspended? && start_date <= Date.today &&
      (end_date.nil? || end_date > Date.today)
  end
end
