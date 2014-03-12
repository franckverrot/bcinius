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
module BC
  require 'rubinius/compiler'

  class UnknownOperator < RuntimeError
  end

  class CompiledCode
    def execute
      script_name = ARGV[0] || ".compiled.rbc"
      cl = Rubinius::CodeLoader.new(script_name)
      cm = cl.load_compiled_file(script_name, 1, 1)
      script = cm.create_script(true)
      script.file_path = script_name
      MAIN.__script__
    end
  end

  class Compiler
    def compile(sexp)
      operand1, operation, operand2 = sexp

      g = Rubinius::ToolSet.current::TS::Generator.new

      g.set_line 1
      g.push_self
      g.push_literal operand1

      if operand2
        g.push_literal operand2
        g.send get_rbx_sym(operation), 1, true
      end

      g.ret
      g.close

      g.encode

      m = g.package Rubinius::CompiledMethod
      f = Rubinius::ToolSet.current::TS::CompiledFile
      f.dump m, ARGV[0] || ".compiled.rbc", 1, 1
      return CompiledCode.new
    end

    def get_rbx_sym(obj)
      case
      when obj == BC::Addition then :+
      when obj == BC::Substraction then :-
      when obj == BC::Multiplication then :*
      when obj == BC::Division then :/
      else
        raise UnknownOperator.new(obj)
      end
    end
  end
end
