require 'pry'
require './lib/pvoutput'
require './lib/qif'

opts = PVOutput::Options.parse(ARGV)

pvo_auth = PVOutput::PVAuth.new(opts['sysid'], opts['apikey'])

binding.pry

# calculate date range
#   if no date params then use last access date from config file
#     if first time run, collect 90 days of data
#   if date from valid but no date to, assume date to is yesterday
if opt['datefrom'].nil? || opt['dateto'].nil?
  
end

# fetch data from PVO
pvstat_data = PVOutput::Statistic.fetch("20150625", "20150625", pvo_auth)


Qif::Writer.open("data/elect_data.qif", type = 'Cash', format = 'dd/mm/yyyy') do |qif|
 
  # all subsequent transactions are for this Account 
#  qif << Qif::Account.new(
#    :name => opts['expense']
#  )
  
  # loop by day
#  qif << Qif::Transaction.new(
#    :date => pvstat_data.actual_date_from,
#    :memo => 'n kw/h',
#    :split_category => opts['expense'],
#    :split_amount => pvstat_data.debit_amount.to_f)

end

binding.pry
