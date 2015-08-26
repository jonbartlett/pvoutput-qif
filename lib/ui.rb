require 'singleton'

module UI

  class Progress
    include Singleton

    def self.msg (msg)
      puts msg
    end
    
    def self.do_something (counter, total)
      print "\r  Comparing files.... #{counter} of #{total}: #{(counter / total)*100 }%"
      print "\n" if counter == total 
    end

  end

  class Banner
    include Singleton

    def self.print
      puts ""
      puts " PVOuput Qif Exporter"
      puts " https://github.com/jonbartlett/pvoutput-qif"
    end
  end

end
