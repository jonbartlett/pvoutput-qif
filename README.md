[![Build Status](https://travis-ci.org/jonbartlett/pvoutput_qif.svg?branch=master)](https://travis-ci.org/jonbartlett/pvoutput_qif)
[![Code Climate](https://codeclimate.com/github/jonbartlett/pvoutput_qif/badges/gpa.svg)](https://codeclimate.com/github/jonbartlett/pvoutput_qif)
[![Test Coverage](https://codeclimate.com/github/jonbartlett/pvoutput_qif/badges/coverage.svg)](https://codeclimate.com/github/jonbartlett/pvoutput_qif/coverage)

# PVOutputQIF 

Financially account for your energy consumption and/or production.

[PVOutput](http://pvoutput.org) aggregates and stores data on solar photovoltaic output and energy consumption. Feed in and consumption tariffs can be entered in PV Output so that it calculates charges or credits from your electricity provider inclusive of standing charges. As electricity providers billing cycle is often quarterly, it is useful to know at any point in time what your upcoming bill will contain. If you use accounting software this credit or debit amount can be entered as an asset or a liability.

This program will generate a QIF file for importing into your favourite accounting package  based on your electricity charges from PVOutput via their API. Developed and tested with [GNUCash](http://www.gnucash.org/).

It also provides a basic Ruby wrapper around the PVOutput API.

## PVOutput Configuration


### Grid Consumption Charges 

Enter KW/h charges 

### Feed in Tariff

### Enable PVOutput API

Configure API Key

## Usage

```bash
Usage: pvoutput_qif.rb [options]

Options:
  --help                        Show this screen.
  --pvosysid SYSID              PVOutput system ID 
  --apikey APIKEY               PVOutput API authentication string
  --datefrom DATEFROM           date from <dd/mm/yyyy> 
  --dateto DATETO               date to <dd/mm/yyyy>
  --assetacct ASSETACCT         QIF asset account name
  --liabilityacct LIABILITYACCT QIF liability account name
  --expenseacct EXPENSEACCT QIF expense account name
  --outputfile QIFFILEPATH      Path to generated QIF file [default: pvo<datefrom><dateto>.qif]
```

For example:

```
pvoutput_qif.rb [options]
```

## Config File


## Unit Tests

MiniTest unit tests can be found in the ```test``` directory.

Tests can be run using:

```bash
rake test
```

or with [Guard](https://github.com/guard/guard):

```bash
bundle exec guard
```

## To Do

* Finalise coding
* Tests
* Release as Gem?

## Further Development

Open an issue to request enhancements. 

Pull requests welcome.

## License

MIT. Use and abuse. No comeback.

