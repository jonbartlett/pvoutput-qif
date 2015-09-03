require 'pry'
require './lib/pvoutput'
require './lib/qif'
require 'date'

UI::Banner.print

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
    # if previous run today then set from date to be yesterday to re-run
    if Date.parse(opts['lastrundate'])== Date.today
      opts['datefrom'] = (Date.today - 1).strftime("%Y%m%d")
    else
      opts['datefrom'] = (Date.parse(opts['lastrundate'])).strftime("%Y%m%d") # last run date 
    end

    opts['dateto'] =  (Date.today - 1).strftime("%Y%m%d") # current date minus 1

  end

end

# fetch data from PVO
pvstat_data = PVOutput::Statistic.fetch(opts['datefrom'], opts['dateto'], pvo_auth)

filename = "#{opts['filedir']}/pvo#{opts['datefrom']}#{opts['dateto']}.qif"

Qif::Writer.open(filename, type = 'Cash', format = 'dd/mm/yyyy') do |qif|
 
  # if liability amount (debit) 
  if pvstat_data.debit_amount.to_f != 0

    # all subsequent transactions are for this Account 
    qif << Qif::Account.new(
      :name => opts['expense']
    )
    # create debit / liability transaction
    qif << Qif::Transaction.new(
      :date => pvstat_data.actual_date_to,
      :memo => "Electricity consumed #{PVOutput::Helper.memo_text(opts, pvstat_data.energy_consumed)}",
      :split_category => opts['liability'],
      :split_amount => pvstat_data.debit_amount.to_f) 
  end 

  # if credit amount
  if pvstat_data.credit_amount.to_f != 0

    # all subsequent transactions are for this Account 
    qif << Qif::Account.new(
      :name => opts['income']
    )

    qif << Qif::Transaction.new(
      :date => pvstat_data.actual_date_to,
      :memo => "Electricity feed in #{Date.parse(opts['datefrom']).strftime('%d/%m/%Y')} to #{Date.parse(opts['dateto']).strftime('%d/%m/%Y')}",
      :split_category => opts['asset'],
      :split_amount => pvstat_data.credit_amount.to_f) 

  end 

end

# update last run date in config file
PVOutput::Options.write_lastrundate (Date.today.strftime("%Y%m%d"))

UI::Progress.msg (" QIF file exported: #{filename}")
