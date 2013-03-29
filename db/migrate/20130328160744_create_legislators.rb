require_relative '../config'

class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |l|
      l.string :title
      l.string :first_name
      l.string :last_name
      l.string :party
      l.string :state
      l.integer :in_office
      l.string :gender
      l.string :twitter_id 
      l.date :birthdate 

    end
  end
end

