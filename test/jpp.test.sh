#!/usr/bin/env sh
test="$(dirname $0)"
jpp="$test/../bin/jpp"

testBasic() {
  result=$($jpp '$' "$test/openapi.json"|wc -l)
  assertEquals 1 $result
}

testPretty() {
  count=$(cat $test/openapi.json|wc -l)
  result=$($jpp --pretty '$' "$test/openapi.json"|wc -l)
  assertEquals $((count + 2)) $result
}

testSeparate() {
  result=$($jpp --separate --jsonpath '$.paths[?(@.get && @.get.parameters)]~' $test/openapi.json|wc -l)

  assertEquals 7 $result
}

testPrefixSuffix() {
  count=$(grep -E '\s*"/.+\: {' $test/openapi.json|wc -l)
  result=$($jpp --separate --before '{0} Endpoints:' --after 'Total {0}' --prefix 'URL {0}: ' --suffix-all ' {0}' '$.paths[*]~' test/openapi.json|grep $count|wc -l)

  # Number of paths appears in before, after and last path entry == 3.
  assertEquals 3 $result
}

testPipe() {
  count=$(grep -E '\s*"/.+\: {' $test/openapi.json|wc -l)
  result=$($jpp '$.paths[*]~' $test/openapi.json|$jpp --pretty '$[0:99:2]'|wc -l)

  # Round odd number of paths up and include array [...] lines
  # https://stackoverflow.com/questions/2395284/round-a-divided-number-in-bash
  assertEquals $(( (count + 1) / 2 + 2 )) $result
}

# Load shUnit2.
. $test/shunit2/shunit2
