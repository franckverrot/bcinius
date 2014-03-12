module BC
  require 'rubinius/compiler'

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
      case obj
      when BC::Addition.class then :+
      else
        # No-op
      end
    end
  end
end
