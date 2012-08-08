require_relative "../test_helper"

# mock class
class Autoscale::Heroku
  def self.workers
    @@workers ||= 0
  end

  def self.workers=(qty)
    @@workers = qty
  end
end

# stub heroku api call to scale
Excon.stub(:expects => 200, :method => :post, :path => %r{^/apps/([^/]+)/ps/scale}) do |params|
  {body: params[:query][:qty], status: 200 } 
end

describe Autoscale::Heroku do
  include QCHelper

  subject { Autoscale::Heroku }
  before { subject.workers = 0 }

  it "job_count should be 0" do
    subject.job_count.must_equal(0)
  end

  it "#workers" do
    subject.workers = 1
    subject.workers.must_equal(1)

    subject.workers = 2
    subject.workers.must_equal(2)
  end

  describe "scaling up" do
    it "with 5 jobs" do
      5.times{ QC.enqueue("Time.now") }
      subject.job_count.must_equal(5)
      subject.workers.must_equal(1)
    end

    it "with 16 jobs" do
      16.times{ QC.enqueue("Time.now") }
      subject.job_count.must_equal(16)
      subject.workers.must_equal(2)
    end

    it "with 31 jobs" do
      31.times{ QC.enqueue("Time.now") }
      subject.job_count.must_equal(31)
      subject.workers.must_equal(3)
    end

    it "with 131 jobs" do
      131.times{ QC.enqueue("Time.now") }
      subject.job_count.must_equal(131)
      subject.workers.must_equal(5)
    end
  end

  describe "scaling down" do
    it "from 31 workers" do
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