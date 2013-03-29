require_relative '../app/models/legislator'

def sens_and_reps_by_state(state)
  sens = Legislator.where("state = ? and title = ?", state, 'Sen').order("first_name")
  reps = Legislator.where("state = ? and title = ?", state, 'Rep').order("first_name")
  sens.map {|l| puts "#{l.in_office} #{l.title} #{l.name}"}
  reps.map {|l| puts "#{l.in_office} #{l.title} #{l.name}"}
end

puts sens_and_reps_by_state('HI')

def gender_count(gender)
  sens_by_gender = Legislator.where("gender = ? and title = ? and in_office = 1", gender, 'Sen').count
  all_sens = Legislator.where("title = ? and in_office = 1", 'Sen').count
  percent = (sens_by_gender.to_f/all_sens)*100
  puts "Male Senators: #{sens_by_gender} (#{percent.to_i}%)"
end

gender_count('M')


