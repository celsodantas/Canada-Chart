require 'rubygems'
require '../month_parser'
require 'rspec'

describe "month parser" do
  
  it "should parse 1 process to current month" do
    processess = [{"processoTempoFederal" => "10"}]
    parse_by_month(processess, 1).should == [1]
  end
  
  it "should parse 2 process to current month" do
    processess = [{"processoTempoFederal" => "10"}, {"processoTempoFederal" => "5"}]
    parse_by_month(processess, 1).should == [2]
  end
  
  it "should parse 1 process from last month" do
    processess = [{"processoTempoFederal" => "30"}]
    parse_by_month(processess, 2).should == [1, 0]
  end
  
  it "should parse process from last month and current" do
    processess = [{"processoTempoFederal" => "5"}, {"processoTempoFederal" => "30"}]
    parse_by_month(processess, 2).should == [1, 1]
  end
  
  it "should parse sparced processess " do
    processess = [{"processoTempoFederal" => "5"}, 
                  {"processoTempoFederal" => "30"},
                  {"processoTempoFederal" => "60"},
                  {"processoTempoFederal" => "60"}]
    parse_by_month(processess, 3).should == [2, 1, 1]
  end
  
end