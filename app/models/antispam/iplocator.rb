module Antispam
  class Iplocator < ApplicationRecord

    def self.get_country(ip_integer)
      ip = Iplocator.find_by("? > ip_from AND ? < ip_to",ip_integer,ip_integer)
      return nil if ip.nil?
      ip.country_code
    end

    def self.import
      require 'csv'
      file_path = File.expand_path('../../../../ip-to-country.csv', __FILE__)
      csv_data = CSV.read(file_path, headers: false)
      csv_data.each do |row|
        begin
          Iplocator.create(
            ip_from: IPAddr.new(row[0]).to_i,
            ip_to: IPAddr.new(row[1]).to_i,
            country_code: row[2]
          )
        rescue
          puts "Error importing row: #{row.inspect}"
        end
      end
      puts "Imported #{csv_data.length} rows."
    end

    def self.ip_to_string(ip)
      ip.split(".").map{|x|x.to_i.to_s(16)}.join("_")
    end

    def self.countries_suspected_of_spam
      %w[CN IN RU BR ID PH TH VN SG NG UA PK BD EG TR ZA MX MA KE]
    end
    def self.trusted_countries
      %w[US DE GB CA AU JP FR NL]
    end
  end

end
