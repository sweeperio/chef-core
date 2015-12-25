EJSON_DATA_BAG_ITEM = %w(ejson keys).freeze
EJSON_PUBLIC_ATTR   = "public".freeze
EJSON_PRIVATE_ATTR  = "private".freeze

resource_name :ejson_key
default_action :add

property :name, String, name_property: true
property :owner, String, required: true, default: "root"
property :group, String, required: true, default: "root"

action :add do
  directory new_resource.dir.path do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.dir.mode
    recursive true
  end

  file new_resource.key.path do
    content new_resource.key.private_key
    owner new_resource.owner
    group new_resource.group
    mode new_resource.key.mode
  end
end

action :remove do
  file new_resource.key.path do
    action :delete
  end
end

def self.keys
  @keys ||= Chef::EncryptedDataBagItem.load(*EJSON_DATA_BAG_ITEM)
end

def key
  @key ||= begin
    item = self.class.keys[name]

    OpenStruct.new(
      mode: 00440,
      path: "/opt/ejson/keys/#{item[EJSON_PUBLIC_ATTR]}",
      private_key: item[EJSON_PRIVATE_ATTR]
    )
  end
end

def dir
  @dir ||= OpenStruct.new(
    mode: 00550,
    path: "/opt/ejson/keys"
  )
end
