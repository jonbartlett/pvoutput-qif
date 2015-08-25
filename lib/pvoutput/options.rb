require 'singleton'
require 'date'
require 'docopt'
require 'yaml'

module PVOutput

  class Options
    include Singleton

    CONFIG_FILE_PATH = './pvoutput_qif.yml'
 
    # entry point
    def self.parse(args)
      parsed_args = clean(read_arguments(args))
      validate(parsed_args)

      if parsed_args["configfilepath"].nil?
        config_args = read_configfile(CONFIG_FILE_PATH) 
      else
        config_args = read_configfile(parsed_args["configfilepath"]) 
      end
      
      merge(parsed_args, config_args)
    end 
 
    # merge config hash with config file hash
    def self.merge (parsed_args, config_args)
      config_args.merge(parsed_args)
    end

    #remove "--" from front of key values in hash and delete empty key pairs
    def self.clean (args_hash)
      args_hash.keys.each { |k| args_hash[k.sub('--','')] = args_hash[k]; args_hash.delete(k) }
      args_hash.delete_if { |key, value| value.nil? }
      args_hash
    end

    # parse config file
    def self.read_configfile (path)
      config = YAML::load_file(path)  
    end

    # validate command line args
    def self.validate (parsed_args)
     
      # date_from and date_to must both be entered or both nil
      if !parsed_args['datefrom'].nil? && parsed_args['dateto'].nil?
        puts "--datefrom requires --dateto to be entered"
        exit
      end

      if parsed_args['datefrom'].nil? && !parsed_args['dateto'].nil?
        puts "--dateto requires --datefrom to be entered"
        exit
      end

      # validate date from format
      begin
        Date.parse(parsed_args['datefrom']) unless parsed_args['datefrom'].nil?
      rescue ArgumentError
        puts "--datefrom must be in format dd/mm/yyyy"
        exit
      end

      
      # validate date format
      begin
        Date.parse(parsed_args['dateto']) unless parsed_args['dateto'].nil?
      rescue ArgumentError
        puts "--dateto must be in format dd/mm/yyyy"
        exit
      end

    end

    # parse command line arguments
    def self.read_arguments(args)

      doc = <<DOCOPT 

      pvoutput_qif.rb

      Usage: pvoutput_qif.rb [--sysid=SYSID] [--apikey=APIKEY] [--datefrom=DATEFROM] [--dateto=DATETO] [--assetacct=ASSETACCT] [--liabilityacct=LIABILITYACCT] [--expenseacct=EXPENSEACCT] [--outputfile=QIFFILEPATH] [--configfilepath=CONFIGFILEPATH]

      Options:
        --help                             Show this screen.
        [--sysid=SYSID]                    PVOutput system ID.
        [--apikey=APIKEY]                  PVOutput API authentication key.
        [--datefrom=DATEFROM]              date from <ddmmyyyy>.
        [--dateto=DATETO]                  date to <ddmmyyyy>.
        [--assetacct=ASSETACCT]            QIF asset account name.
        [--liabilityacct=LIABILITYACCT]    QIF liability account name.
        [--expenseacct=EXPENSEACCT]        QIF expense account name.
        [--outputfile=QIFFILEPATH]         Path to generate QIF file.
        [--configfilepath=CONFIGFILEPATH]  Path to optional config file [default: pvoutput_qif.yml]

DOCOPT

      begin
        params = {:argv => args}
        Docopt::docopt(doc, params)
      rescue Docopt::Exit => e
        puts e.message
        exit
      end

    end
  end
end
