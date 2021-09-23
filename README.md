# jsonpath-cli
Command-Line interface for the jsonpath library.

The `jpp` command enables running the jsonpath-plus library against files from
the command line. JSONPath searches return a JSON array which `jpp` outputs.
The `--pretty` option pretty-prints the output.  Additionally, the 

## Examples

**List the paths in an OAS specification:**
> `jpp --pretty openapi.json '$.paths.*~'`

**List the paths with put or post operations:**
> `jpp --pretty openapi.json '$.paths[?(@.put || @.post)]~'`

**List the paths with get operations taking parameters:**
> `cat openapi.json | jpp --separate --jsonpath '$.paths[?(@.get && @.get.parameters)]~' --output matches.txt`

*Note that jpp can read from standard input and output to named files.*

## Usage

```
Usage: jpp [options] [JSON Input File] [JSONPath Expression]

Options:
  -V, --version                display version
  -i, --input <file>           input JSON file (default: stdin)
  -j, --jsonpath <expression>  matching expression
  -o, --output <file>          output file for matches (default: stdout)
  -p, --pretty                 pretty print matches (default: false)
  -s, --separate               output each match separately (default: false)
  -h, --help                   display help for command
```
