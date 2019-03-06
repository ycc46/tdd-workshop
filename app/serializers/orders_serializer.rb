class OrdersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total, :user_id

  belongs_to :user
end
