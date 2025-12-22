require "redis"
require "econfig/redis"

describe Econfig::Redis do
  let(:redis) { double(Redis) }
  let(:backend) { Econfig::Redis.new(redis) }

  describe "#keys" do
    it "returns a list of set keys" do
      allow(redis)
        .to receive(:keys)
        .and_return(["foo", "bar"])

      backend.keys.should(eq(Set.new(["foo", "bar"])))
    end
  end

  describe "#has_key?" do
    it "returns the value from the redis instance" do
      allow(redis)
        .to receive(:exists)
        .with("foo")
        .and_return(:a_nice_value)

      backend.has_key?("foo").should(eq(:a_nice_value))
    end
  end

  describe "#get" do
    it "returns the value from the redis instance" do
      allow(redis)
        .to receive(:get)
        .with("foobarfoo")
        .and_return(:a_not_so_nice_value)

      backend.get("foobarfoo").should(eq(:a_not_so_nice_value))
    end
  end

  describe "#set" do
    it "sets the value in the redis instance" do
      expect(redis)
        .to receive(:set)
        .with("a_beautiful_key", "a_nice_value")

      backend.set("a_beautiful_key", "a_nice_value")
    end
  end
end
