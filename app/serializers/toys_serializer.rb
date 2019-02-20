class ToysSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :price, :published, :user_id
end
