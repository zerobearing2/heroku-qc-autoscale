require_relative "../../test_helper"

describe QC::Queue do
  subject { QC::Queue.new("default-test") }

  it "should respond to #enqueue_with_callbacks" do
    subject.must_respond_to(:enqueue_with_callbacks)
  end

  it "should respond to #delete_with_callbacks" do
    subject.must_respond_to(:delete_with_callbacks)
  end
end