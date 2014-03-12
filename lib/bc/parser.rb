# bcinius - A bc implementation based on Rubinius
# Copyright (C) 2014 Franck Verrot <franck@verrot.fr>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
require 'treetop'
require 'polyglot'

module BCinius
  class ExpressionNode < Treetop::Runtime::SyntaxNode
    def visit(generator)
      operand1.visit(generator)

      if respond_to?(:operation)
        if operation.respond_to?(:operator)
          operation.operand2.visit(generator)
          operation.operator.visit(generator)
        end
      end
    end
  end

  class AdditionNode < Treetop::Runtime::SyntaxNode
    def visit(generator)
      generator.send :+, 1, true
    end
  end

  class MultiplicationNode < Treetop::Runtime::SyntaxNode
    def visit(generator)
      generator.send :*, 1, true
    end
  end

  class SubstractionNode < Treetop::Runtime::SyntaxNode
    def visit(generator)
      generator.send :-, 1, true
    end
  end

  class DivisionNode < Treetop::Runtime::SyntaxNode
    def visit(generator)
      generator.send :/, 1, true
    end
  end

  class LiteralNode < Treetop::Runtime::SyntaxNode
    def visit(generator)
      val = if text_value.include?(".")
        Float(text_value)
      else
        Integer(text_value)
      end

      generator.push_literal val
    end
  end
end

Treetop.load 'lib/grammar'

module BC
  class UnknownToken < RuntimeError
    attr_reader :position

    def initialize(token_repr, position)
      super(token_repr)
      @position = position
    end
  end

  class Addition; end
  class Substraction; end
  class Multiplication; end
  class Division; end


  class Parser
    def parse(str)
      parser = ::BCiniusParser.new
      result = nil
      begin
        result = parser.parse(str)
      rescue Exception => e
        puts "[" + e.inspect
        puts parser.inspect
        puts result.inspect
        puts "["
      end

      if !result
        if parser.terminal_failures.any?
          msg = parser.terminal_failures.join("\n")
          parser.failure_reason =~ /^(Expected .+) after/m
          msg += "\n#{$1.gsub("\n", '$NEWLINE')}:\n"
          msg += "\n#{str.lines.to_a[parser.failure_line - 1]}\n"
          msg += "\n#{'~' * (parser.failure_column - 1)}^\n"
          raise BC::UnknownToken.new(msg, parser.failure_column - 1)
        end
      else
        result
      end
    end
  end
end
