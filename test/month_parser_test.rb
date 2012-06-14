require 'rubygems'
require '../month_parser'
require 'rspec'

describe "month parser" do
  
  it "should parse 1 process to current month" do
    processess = [{"processoTempoFederal" => 10}]
    parse_by_month(processess, 1).should == [1]
  end
  
end