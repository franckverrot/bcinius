.PHONY: test

test: parser compiler

parser:
	ruby -Ilib:test test/bcinius/parser_test.rb

compiler:
	ruby -Ilib:test test/bcinius/compiler_test.rb
