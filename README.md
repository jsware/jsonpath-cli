# jsonpath-cli
Command-Line interface for the `jsonpath-plus` library.

The `jpp` command enables running the `jsonpath-plus` library against files from
the command line. JSONPath searches return a JSON array which `jpp` outputs.
The `--pretty` option pretty-prints the output.  Additional command line options
can be found below.

See the [documentation](https://www.jsware.io/jsonpath-cli) for examples,
JSONPath expression syntax and additional details.

## Installation
```
npm install -g @jsware/jsonpath-cli
```

## Usage

```
Usage: jpp [options] [JSONPath Expression] [JSON Input File]

Options:
  -V, --version                display version
  -i, --input <file>           input JSON file (default: stdin)
  -e, --jsonpath <expression>  matching expression
  -o, --output <file>          output file for matches (default: stdout)
  -p, --pretty                 pretty print matches (default: false)
  -s, --separate               output each match separately (default: false)
  -r, --prefix [prefix]        prefix when using --separate (default: false)
  -h, --help                   display help for command
```
