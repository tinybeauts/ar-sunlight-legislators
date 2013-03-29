require 'csv'
require_relative '../app/models/legislator'

IMPORTANT_FIELDS = [:title, 
                    :first_name, 
                    :last_name, 
                    :party, 
                    :state,
                    :in_office,
                    :gender,
                    :twitter_id,
                    :birthdate
                  ]

class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      info = {}
      row.each do |field, value|

        field = field.to_sym
        
        if field == :birthdate
          month = value[0..1].to_i
          day = value[3..4].to_i
          year = value[6..-1].to_i
          value = Date.new(year, month, day)
        end

        info = info.merge(field => value) if IMPORTANT_FIELDS.include? field

      end
      legislator = Legislator.create!(info)
    end
  end
end

SunlightLegislatorsImporter.import('db/data/legislators.csv')

# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
