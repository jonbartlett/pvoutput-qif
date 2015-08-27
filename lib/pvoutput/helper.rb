require 'singleton'

module PVOutput

  class Helper
    include Singleton

    def self.watts_to_kw (watt_value)
      "%0.3f" % ((watt_value.to_f) / 1000) unless watt_value == 0
    end

    def self.kw_per_day (energy, days)
     "#{energy.to_f / days.to_f}"
    end

    def self.format_date(date_string)
      Date.parse(date_string).strftime('%d/%m/%Y')
    end

    def self.days_diff (date_from, date_to)
      diff = Date.parse(date_to) - Date.parse(date_from)
      if diff == 0
        1
      else 
        diff
      end
    end

    def self.memo_text (opts, energy_amt)
      "#{format_date(opts['datefrom'])} to #{format_date(opts['dateto'])} (#{days_diff(opts['datefrom'],opts['dateto'])} days) "\
      "= #{watts_to_kw(energy_amt)} kWh (#{watts_to_kw(kw_per_day(energy_amt, days_diff(opts['datefrom'],opts['dateto'])))} kWh/day)"
    end

  end

end
