#!/usr/bin/env sh
test="$(dirname $0)"
jpp="$test/../bin/jpp"

testBasic() {
  result=$($jpp '$' "$test/openapi.json"|wc -l)
  assertEquals $result 1
}

testPretty() {
  count=$(cat $test/openapi.json|wc -l)
  result=$($jpp --pretty '$' "$test/openapi.json"|wc -l)
  assertEquals $result $((count +2))
}

testSeparate() {
  result=$($jpp --separate --jsonpath '$.paths[?(@.get && @.get.parameters)]~' $test/openapi.json|wc -l)

  assertEquals $result 7
}

# Load shUnit2.
. $test/shunit2/shunit2
