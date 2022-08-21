#!/bin/bash

printf "Fake generator generating included_file.hpp..."
printf "namespace {}" > included_file.hpp

printf "Fake generator generating source_${1}.cpp/hpp..."
printf "#include <string> \n std::string test_${1}();" > source_${1}.hpp
printf "#include \"source_${1}.hpp\" \n #include \"included_file.hpp\" \n std::string test_${1}() { return \"library ${1}\"; }" > source_${1}.cpp