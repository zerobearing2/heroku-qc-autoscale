require_relative "../test_helper"

describe Autoscale::Heroku do
  include QCHelper

  subject { Autoscale::Heroku }

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

  describe "scaling up" do
    it "with 5 jobs" do
      with_app do |app|
        5.times{ QC.enqueue("Time.now") }
        subject.workers.must_equal(1)
      end
    end

    it "with 16 jobs" do
      with_app do |app|
        16.times{ QC.enqueue("Time.now") }
        subject.workers.must_equal(2)
      end
    end

    it "with 31 jobs" do
      with_app do |app|
        31.times{ QC.enqueue("Time.now") }
        subject.workers.must_equal(3)
      end
    end

    it "with 131 jobs" do
      with_app do |app|
        131.times{ QC.enqueue("Time.now") }
        subject.workers.must_equal(5)
      end
    end
  end

  describe "scaling down" do

    it "from 31 workers" do
      with_app do |app|
        # add jobs to queue
        31.times{ QC.enqueue("Time.now") }
        subject.workers.must_equal(3)
        
        # do work and scale back down
        31.times{ QC::Worker.new.work }
        subject.job_count.must_equal(0)
        subject.workers.must_equal(0)
      end
    end

  end

end