[![Build Status](https://travis-ci.org/jonbartlett/pvoutput-qif.svg?branch=master)](https://travis-ci.org/jonbartlett/pvoutput-qif)
[![Code Climate](https://codeclimate.com/github/jonbartlett/pvoutput-qif/badges/gpa.svg)](https://codeclimate.com/github/jonbartlett/pvoutput-qif)
[![Test Coverage](https://codeclimate.com/github/jonbartlett/pvoutput-qif/badges/coverage.svg)](https://codeclimate.com/github/jonbartlett/pvoutput-qif/coverage)

Financially account for your energy consumption and/or production between billing cycles.

[PVOutput](http://pvoutput.org) aggregates and stores data on solar photovoltaic output and energy consumption. Feed in and consumption tariffs can be entered in PV Output so that it calculates charges or credits from your electricity provider inclusive of standing charges. As electricity providers billing cycle is often quarterly, it is useful to know at any point in time what your upcoming bill will contain. If you use accounting software this credit or debit amount can be entered as an asset or a liability.

This application generates a QIF file based on your electricity charges from PVOutput via their API which can be imported into your favourite accounting package. Developed and tested with [GNUCash](http://www.gnucash.org/).

Also provided is a basic Ruby wrapper around the PVOutput API.

For more information see my blog post on the subject [here](http://www.jonbartlett.org/notes/electricity-consumption-generation-accounting/).

## Usage

Edit config file ```pvoutput_qif.yml``` or pass configuration at the command line. Command line options override options in the config file.

```bash
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
```

## Unit Tests

Some MiniTest unit tests can be found in the ```test``` directory.

Tests can be run using:

```bash
rake test
```

or with [Guard](https://github.com/guard/guard):

```bash
bundle exec guard
```

## Debugging

If you run into issues calling the PVOutput API, enable (Rest Cleint)[https://github.com/rest-client/rest-client] logging run as follows:

```RESTCLIENT_LOG=stdout pvoutput_qif.rb```

this will show the exact http call made to the API.

## To Do

* test coverage
* package into a gem
* utilise qif gem rather than source
* refactor

## Future Development

Open an issue to request enhancements. 

Pull requests welcome.

## License

MIT. Use and abuse. No comeback.

