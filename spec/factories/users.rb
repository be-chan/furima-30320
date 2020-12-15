FactoryBot.define do
  factory :user do
    nickname { 'furima太郎' }
    email                 { 'test@com' }
    password              { '000000a' }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birthday              { '1930-1-1' }
  end
end
