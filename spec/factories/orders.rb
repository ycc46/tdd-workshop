FactoryBot.define do
  factory :order do
    total { "%.2f" % (rand() * 100) }
    user
  end
end
