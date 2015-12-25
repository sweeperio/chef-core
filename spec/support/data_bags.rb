shared_context "with data bags", :data_bags do
  let(:test_key) { ejson_keys["test_key"] }
  let(:dead_key) { ejson_keys["dead_key"] }

  before do
    allow(Chef::EncryptedDataBagItem).to receive(:load).with("ejson", "keys").and_return(ejson_keys)
  end

  def ejson_keys
    {
      "test_key" => {
        "public" => "1234567890",
        "private" => "0987654321"
      },
      "dead_key" => {
        "public" => "dead1234",
        "private" => "4321daed"
      }
    }
  end
end
