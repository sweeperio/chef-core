describe "ejson_key resource", :data_bags do
  shared_examples "an ejson_key resource" do
    it "creates the ejson folder" do
      expect(chef_run).to create_directory("/opt/ejson/keys").with(
        mode: 00550,
        owner: owner,
        group: group,
        recursive: true
      )
    end

    it "adds ejson keys" do
      expect(chef_run).to add_ejson_key("test_key")
      expect(chef_run).to create_file("/opt/ejson/keys/#{test_key['public']}").with(
        content: test_key["private"],
        mode: 00440,
        owner: owner,
        group: group
      )
    end

    it "removes ejson keys" do
      expect(chef_run).to remove_ejson_key("dead_key")
      expect(chef_run).to delete_file("/opt/ejson/keys/#{dead_key['public']}")
    end
  end

  context "with default attributes" do
    let(:owner) { "root" }
    let(:group) { "root" }

    cached(:chef_run) do
      runner = ChefSpec::SoloRunner.new(step_into: "ejson_key")
      runner.converge("recipe[test::ejson]")
    end

    it_behaves_like "an ejson_key resource"
  end

  context "when owner and group are overridden" do
    let(:owner) { "deploy_user" }
    let(:group) { "deploy_group" }

    cached(:chef_run) do
      runner = ChefSpec::SoloRunner.new(step_into: "ejson_key") do |node|
        node.set["test"]["ejson"]["owner"] = owner
        node.set["test"]["ejson"]["group"] = group
      end

      runner.converge("recipe[test::ejson]")
    end

    it_behaves_like "an ejson_key resource"
  end
end
