if defined?(ChefSpec)
  def add_ejson_key(name)
    ChefSpec::Matchers::ResourceMatcher.new(:ejson_key, :add, name)
  end

  def remove_ejson_key(name)
    ChefSpec::Matchers::ResourceMatcher.new(:ejson_key, :remove, name)
  end
end
