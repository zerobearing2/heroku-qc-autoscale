require_relative "../test_helper"

describe Heroku::Scaler do
  include QCHelper

  subject { Heroku::Scaler }

  it "job_count should be 0" do
    subject.job_count.must_equal(0)
  end

  it "#workers" do
    with_app do |app|
      subject.workers = 1
      subject.workers.must_equal(1)

      subject.workers = 2
      subject.workers.must_equal(2)
    end
  end

end