require_relative "./test_helper"

describe Autoscale do
  subject { Autoscale }

  it "should have api_key" do
    subject.api_key.must_equal("123456")
  end

  it "should have app name" do
    subject.app.must_match /racehq-test/
  end

  it "should have scale" do
    subject.scale.must_equal [1, 15, 30, 40, 50]
  end

  it "should have min workers" do
    subject.min.must_equal 0
  end

end