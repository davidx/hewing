# Hewing

A simple log processing tool.

## Installation

```
> git clone 'https://github.com/davidx/hewing.git'
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

