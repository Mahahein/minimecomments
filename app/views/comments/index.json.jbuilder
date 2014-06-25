json.array!(@comments) do |comment|
  json.extract! comment, :id, :user, :message, :time_sent, :isFixed
  json.url comment_url(comment, format: :json)
end
