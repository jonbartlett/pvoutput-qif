require 'pry'
require 'qif'
require './lib/pvoutput/pvauth'
require './lib/pvoutput/statistic'

pvo_auth = PVOutput::PVAuth.new('8313', 'dc31fc56cff51f')

stat_data = PVOutput::Statistic.fetch("20150625", "20150625", pvo_auth)


Qif::Writer.open("test.qif", type = 'Cash', format = 'dd/mm/yyyy') do |qif|
  
  qif << Qif::Transaction.new(
    :date => stat_data.actual_date_from,
    :amount => stat_data.debit_amount.to_f,
    :memo => 'Test trx')

end

binding.pry
