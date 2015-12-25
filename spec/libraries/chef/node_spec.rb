require "./libraries/chef/node"

describe Chef::Node do
  let(:node) { described_class.new }

  context "attribute extensions" do
    before do
      node.set["dummy"]                = "value"
      node.set["test"]["deep"]["attr"] = "deep value"
    end

    describe "#attr" do
      it "can handle single level attributes" do
        expect(node.attr("dummy")).to eq("value")
      end

      it "fetches nested attribute if it exists" do
        expect(node.attr("test", "deep", "attr")).to eq("deep value")
      end

      it "returns nil when key not found at any level" do
        expect(node.attr("what", "is", "this")).to be_nil
        expect(node.attr("test", "shallow")).to be_nil
        expect(node.attr("test", "deep", "missing")).to be_nil
      end
    end

    describe "#attr?" do
      it "returns true when the attribute exists" do
        expect(node.attr?("dummy")).to be(true)
        expect(node.attr?("test", "deep")).to be(true)
        expect(node.attr?("test", "deep", "attr")).to be(true)
      end

      it "returns false when the attribute doesn't exist" do
        expect(node.attr?("thingy")).to_not be(true)
        expect(node.attr?("test", "wat")).to_not be(true)
        expect(node.attr?("test", "deep", "thing")).to_not be(true)
        expect(node.attr?("test", "wat", "attr")).to_not be(true)
      end
    end

    describe "#attr!" do
      it "returns the attribute if found" do
        expect(node.attr!("test", "deep", "attr")).to eq("deep value")
      end

      it "raises AttributeDoesNotExistError when an attribute is not available" do
        expect { node.attr!("test", "missing") }.to raise_error(Chef::Node::AttributeDoesNotExistError)
      end
    end
  end
end
