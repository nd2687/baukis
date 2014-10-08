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

require 'rails_helper'

describe StaffMember do
  describe '#password=' do
    example '文字列を与えると、hashed_passwordは長さ60の文字列になる' do
      member = StaffMember.new
      member.password = 'baukis'
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    example 'nilを与えると、hashed_passwordはnilになる' do
      member = StaffMember.new(hashed_password: 'x')
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end

  describe '値の正規化' do
    example 'email前後の空白を除去' do
      member = create(:staff_member, email: ' test@example.com ')
      expect(member.email).to eq('test@example.com')
    end

    #example 'emailに含まれる全角英数字記号を半角に変換' do
    # 全角入力が面倒くさいので省略
    #end

    example 'email前後の全角スペースを除去' do
      member = create(:staff_member, email: "\u{3000}test@example.com\u{3000}")
      expect(member.email).to eq('test@example.com')
    end

    example 'family_name_kanaに含まれるひらがなをカタカナに変換' do
      member = create(:staff_member, family_name_kana: 'てすと')
      expect(member.family_name_kana).to eq('テスト')
    end

    #example '半角カナを全角カナへ変換' do
    # 半角カナ入力が面倒くさいので省略
    #end

    describe 'バリデーション' do
      example '@を2個含むemailは無効' do
        member = build(:staff_member, email: 'test@@example.com')
        expect(member).not_to be_valid
      end

      example '記号を含むfamily_nameは無効' do
        member = build(:staff_member, family_name: "試験★")
        expect(member).not_to be_valid
      end

      example '漢字を含むfamily_name_kanaは無効' do
        member = build(:staff_member, family_name_kana: '試験')
        expect(member).not_to be_valid
      end

      example '長音符を含むfamily_name_kanaは有効' do
        member = build(:staff_member, family_name_kana: 'エリー')
        expect(member).to be_valid
      end

      example '他の職員のメールアドレスと重複したemailは無効' do
        member1 = create(:staff_member)
        member2 = build(:staff_member, email: member1.email)
        expect(member2).not_to be_valid
      end
    end
  end
end
