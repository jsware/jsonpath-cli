# jsonpath-cli
Command-Line interface for the jsonpath-plus library.

The `jpp` command enables running the jsonpath-plus library against files from
the command line. JSONPath searches return a JSON array which `jpp` outputs.
The `--pretty` option pretty-prints the output.  Additional command line options
can be found below.

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

The positional parameters, options, stdin and stdout can be used as alternative
ways to control `jpp` as required. *To pipe output through `jpp` use the
`--jsonpath` option to specify just the JSONPath expression.*

JSONPath returns an array of matches, which `jpp` outputs as a single array
result (i.e. wrapped in array square brackets). Use `--separate` to output each
result in turn. The `--prefix` option will prefix each match with the prefix
text, replacing `{0}` in the text with the match index startig at 1. Using
`--prefix` without a value defaults to `"{0} "`).

## Examples

Once installed, the `jpp` command can be used to execute JSONPath expressions
against JSON files. For exampe, using the petstore OAS openapi.json file:

**List the paths in an OAS specification:**
> `jpp --pretty openapi.json '$.paths.*~'`

prints:
```
[
  "/pet",
  "/pet/findByStatus",
  "/pet/findByTags",
  "/pet/{petId}",
  "/pet/{petId}/uploadImage",
  "/store/inventory",
  "/store/order",
  "/store/order/{orderId}",
  "/user",
  "/user/createWithList",
  "/user/login",
  "/user/logout",
  "/user/{username}"
]
```

**List the paths with put or post operations:**
> `jpp --pretty openapi.json '$.paths[?(@.put || @.post)]~'`

prints:
```
[
  "/pet",
  "/pet/{petId}",
  "/pet/{petId}/uploadImage",
  "/store/order",
  "/user",
  "/user/createWithList",
  "/user/{username}"
]
```

**Save the paths with get operations taking parameters:**
> `cat openapi.json | jpp --separate --jsonpath '$.paths[?(@.get && @.get.parameters)]~' --output matches.txt`

creates `matches.txt` containing:
```
"/pet/findByStatus"
"/pet/findByTags"
"/pet/{petId}"
"/store/order/{orderId}"
"/user/login"
"/user/logout"
"/user/{username}"
```

**Print the paths, each match prefixed with the match number:**
> `jpp --separate --prefix '{0}: ' '$.paths[*]~' openapi.json`

prints:
```
1: "/pet"
2: "/pet/findByStatus"
3: "/pet/findByTags"
4: "/pet/{petId}"
5: "/pet/{petId}/uploadImage"
6: "/store/inventory"
7: "/store/order"
8: "/store/order/{orderId}"
9: "/user"
10: "/user/createWithList"
11: "/user/login"
12: "/user/logout"
13: "/user/{username}"
```
