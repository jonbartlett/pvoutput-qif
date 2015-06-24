[![Build Status](https://travis-ci.org/jonbartlett/pvoutput_qif.svg?branch=master)](https://travis-ci.org/jonbartlett/pvoutput_qif)
[![Code Climate](https://codeclimate.com/github/jonbartlett/pvoutput_qif/badges/gpa.svg)](https://codeclimate.com/github/jonbartlett/pvoutput_qif)
[![Test Coverage](https://codeclimate.com/github/jonbartlett/pvoutput_qif/badges/coverage.svg)](https://codeclimate.com/github/jonbartlett/pvoutput_qif/coverage)

# PVOutput_QIF 

[PVOutput](http://pvoutput.org) aggregates and stores data on solar photovoltaic output and energy consumption. 

## PVOutput Configuration

### Grid Consumption Charges 

### Feed in Tariff

### Enable PVOutput API

## Usage

Retrieve 

```bash
ruby pvoutput_qif.rb  
```

The following options are available:

```bash
	-s  --systemid        PVOutput system ID 
 -a  --authid          PVOutput API authentication string
 -df --datefrom        date from <dd/mm/yyyy>
 -dt --dateto          date to <dd/mm/yyyy>
 -af --qifaccountfrom  QIF account from
 -at --qifaccountto    QIF account to
```

The QIF file will be created as follows:

```bash
pvoutput<systemid>_<datefrom>_<dateto>.qif
```

## Limitations

Running for the current day will result in partial data. 

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

## Further Development

Open an issue to request enhancements. 

## References
* [Wrapping Your API In A Custom Ruby Gem](https://blog.engineyard.com/2014/wrapping-your-api-in-a-ruby-gem) - Thoughtworks

## License

MIT. Use and abuse. No comeback.



