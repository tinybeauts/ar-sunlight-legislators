require 'rspec'
require_relative '../app/models/legislator'

describe Legislator, "existence" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:legislators).should be_true
    Legislator.delete_all

    @legislator = Legislator.new
    @legislator.assign_attributes(
      :title => "Sen",
      :first_name => "Happy",
      :last_name => "Gilmore",
      :gender => 'M',
      :party => 'D',
      :state => 'CA'
    )
  end

  it "should have name and age methods" do
    [:name, :age].each { |mthd| @legislator.should respond_to mthd }
  end

end

describe Legislator, "validations" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:legislators).should be_true
    Legislator.delete_all

    @legislator = Legislator.new
    @legislator.assign_attributes(
      :title => "Rep",
      :first_name => "Happy",
      :last_name => "Gilmore",
      :gender => 'M',
      :party => 'D',
      :state => 'CA',
      :birthdate => Date.new(1980,9,11)
    )
  end

  it "shouldn't accept people too young to be representatives" do
    @legislator.assign_attributes(:birthdate => Date.today - 3.years)
    @legislator.should_not be_valid
  end

  it "shouldn't accept people too young to be senators" do
    @legislator.assign_attributes(:birthdate => Date.today - 3.years, :title => 'Sen')
    @legislator.should_not be_valid
  end  

end
