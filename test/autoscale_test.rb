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

  describe "configure" do
    subject { Autoscale }

    it "should set connect timeout to 15s" do
      Autoscale.connect_timeout = 15
      subject.connect_timeout.must_equal(15)
    end

    it "should set read timeout to 60s" do
      Autoscale.read_timeout = 60
      subject.read_timeout.must_equal(60)
    end

    it "should set write timeout to 60s" do
      Autoscale.write_timeout = 60
      subject.write_timeout.must_equal(60)
    end
  end

end
