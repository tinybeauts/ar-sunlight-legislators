require 'csv'

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
        # raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
        field = field.to_sym
        info = info.merge(field => value) if IMPORTANT_FIELDS.include? field
      end

    end
  end
end

SunlightLegislatorsImporter.import('db/data/legislators.csv')
