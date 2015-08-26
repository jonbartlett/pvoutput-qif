require 'pry'
require './lib/pvoutput'
require './lib/qif'
require 'date'

opts = PVOutput::Options.parse(ARGV)

pvo_auth = PVOutput::PVAuth.new(opts['sysid'], opts['apikey'])


# calculate date range
#   if no date params then use last access date from config file
#     if first time run, collect 90 days of data
if opts['datefrom'].nil? && opts['dateto'].nil?
 
  # if first time run (no last run date in yml file)
  if opts['lastrundate'].nil?
    opts['datefrom'] = (Date.today - 90).strftime("%Y%m%d")
    opts['dateto'] = (Date.today - 1).strftime("%Y%m%d")
  else
    opts['datefrom'] = (Date.parse(opts['lastrundate']) + 1).strftime("%Y%m%d") # last run date plus 1
    opts['dateto'] =  (Date.today - 1).strftime("%Y%m%d") # current date minus 1
  end

end

# fetch data from PVO
pvstat_data = PVOutput::Statistic.fetch(opts['datefrom'], opts['dateto'], pvo_auth)

Qif::Writer.open("#{opts['filedir']}/pvo#{opts['datefrom']}#{opts['dateto']}.qif", type = 'Cash', format = 'dd/mm/yyyy') do |qif|
 
  # if liability amount (debit) 
  if pvstat_data.debit_amount.to_f != 0

    # all subsequent transactions are for this Account 
    qif << Qif::Account.new(
      :name => opts['liability']
    )
    
    # create debit / liability transaction
    qif << Qif::Transaction.new(
      :date => pvstat_data.actual_date_to,
      :memo => "electricity consumed #{Date.parse(opts['datefrom']).strftime('%d/%m/%Y')} to #{Date.parse(opts['dateto']).strftime('%d/%m/%Y')} = #{pvstat_data.energy_consumed} Watts",
      :split_category => opts['liability'],
      :split_amount => pvstat_data.debit_amount.to_f) 
  end 

  # if credit amount
  if pvstat_data.credit_amount.to_f != 0

    # all subsequent transactions are for this Account 
    qif << Qif::Account.new(
      :name => opts['asset']
    )

    qif << Qif::Transaction.new(
      :date => pvstat_data.actual_date_to,
      :memo => "electricity feed in #{Date.parse(opts['datefrom']).strftime('%d/%m/%Y')} to #{Date.parse(opts['dateto']).strftime('%d/%m/%Y')}",
      :split_category => opts['asset'],
      :split_amount => pvstat_data.credit_amount.to_f) 

  end 

end

# update last run date in config file


