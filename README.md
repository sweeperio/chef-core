# core

[![Build Status](https://travis-ci.org/sweeperio/chef-core.svg?branch=master)](https://travis-ci.org/sweeperio/chef-core)

A library cookbook that can be used across the organization. There are some assumptions made here (like the names of
data bags, etc.) that kinda render this useless outside of our chef setup.

## Libraries

A collection of useful extensions/libraries.

### Chef::Node Extensions

#### `attr`, `attr?` and `attr!`

Fetch arbitrarily deeply nested attributes from a node.

```ruby
# will fetch node["authorization"]["sudo"]["users"] or return nil
node.attr("authorization", "sudo", "users")

# will fetch node["authorization"]["sudo"]["users"] or raise
node.attr!("authorization", "sudo", "users")

# check whether or not the attribute exists
node.attr?("authorization", "sudo", "users")
```

## Custom Resources

Custom resources that this cookbook exposes. This cookbook uses the updated [custom resource] approach, therefore Chef 12.5 or newer is required.

[custom resource]: https://docs.chef.io/custom_resources.html

### ejson_key

Adds/removes [ejson] keys to/from `/opt/ejson/keys`. This resource will look for an entry in the
encrypted data bag `ejson/keys`.

Each entry in the data bag should have `public` and `private` attributes for the public and private key respectively.

#### Properties

* `action` - The action to take, `[:add, :remove]`. Default `:add`
* `owner` - The owner of the file. Default `root`
* `group` - The group owner of the file. Default `root`

#### Usage

In these examples, an entry for `dude` will be retrieved from the `ejson/keys` data bag (expected to be encrypted).

```ruby
# creates /opt/ejson/keys/#{public_key} with the private key as it's content
ejson_key "dude"

# remove a key
ejson_key "dude" do
  action :remove
end
```

[ejson]: https://github.com/Shopify/ejson
