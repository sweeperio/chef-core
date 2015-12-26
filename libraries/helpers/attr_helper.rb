module Core::Helpers::AttrHelper
  class AttributeDoesNotExistError < StandardError; end

  def attr(*keys)
    attr!(*keys)
  rescue AttributeDoesNotExistError
    nil
  end

  def attr?(*keys)
    # rubocop:disable Style/Attr
    !attr(*keys).nil?
    # rubocop:enable Style/Attr
  end

  def attr!(*keys)
    keys.map!(&:to_s)

    keys.inject(attributes.to_hash) do |hash, key|
      raise_attribute_not_found(keys) unless hash.key?(key)
      hash.fetch(key)
    end
  end

  private

  def raise_attribute_not_found(keys)
    hash    = keys.map { |key| "['#{key}']" }
    message = "No attribute `node#{hash.join}` exists on the current node."
    fail AttributeDoesNotExistError, message
  end
end
