require_relative '../../db/config'

class Legislator < ActiveRecord::Base

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def age
    now = Date.today
    age = now.year - self.birthdate.year - ((now.month > self.birthdate.month || (now.month == self.birthdate.month && now.day >= self.birthdate.day)) ? 0 : 1)
  end

  validates :age, :numericality => { :greater_than => 25 }, :if => Proc.new { |l| l.title == 'Rep' }
  validates :age, :numericality => { :greater_than => 30 }, :if => Proc.new { |l| l.title == 'Sen' }

end

