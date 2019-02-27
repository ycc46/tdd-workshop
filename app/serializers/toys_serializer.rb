class ToysSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :price, :published, :user_id

  belongs_to :user
end
