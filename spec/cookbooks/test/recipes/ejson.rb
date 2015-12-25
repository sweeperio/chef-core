if node.attr?("test", "ejson", "owner")
  owner = node.attr!("test", "ejson", "owner")
  group = node.attr!("test", "ejson", "group")

  ejson_key "test_key" do
    owner owner
    group group
  end
else
  ejson_key "test_key"
end

ejson_key "dead_key" do
  action :remove
end
