require_relative "./test_helper"

describe Heroku::QC::Autoscale do
  
  before do
    Heroku::QC::Autoscale.config do |c|
      c.api_key = "123456"
    end
  end
  
  subject { Heroku::QC::Autoscale }

  it "should have api_key" do
    subject.api_key.must_equal("123456")
  end

  it "should change api_key at runtime" do
    subject.api_key.must_equal("123456")
    subject.api_key = "654321"    
    subject.api_key.must_equal("654321")
  end

end