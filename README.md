# Hewing

A simple log processing tool.
This tool was created as an ruby exercise.
Original requirements:
Write a command line tool that parses the log and presents the following info to the user:
    - What are the number of requests served by day?
    - What are the 3 most frequent User Agents by day?
    - What is the ratio of GET's to POST's by OS by day?

## Installation

```
> git clone https://github.com/davidx/hewing.git
> cd hewing
> rake install
```
## Test
```
> rake test
```
## Usage

```
> hewing -h 
Usage: hewing [-fdv]

Specific options:
    -f, --file=FILE                  The log file you would like to analyze

Common options: 
        --help                       Show this message
    -d, --debug                      Show debug (verbose)
    -v, --version                    Show version
```
#### Generate report
```
> hewing -f test/data/sample.log -d
```

## Contributing

1. Fork it ( https://github.com/davidx/hewing/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

