module BC
  class Parser
    def parse(str)
      decimal = ""
      unit, pos = consume_number_literal(str, 0)
      if /\./.match(str[pos])
        decimal, pos = consume_number_literal(str, pos + 1)
      end
      if decimal.empty?
        Integer(unit)
      else
        Float("#{unit}.#{decimal}")
      end
    end

    def consume_number_literal(str, pos)
      token = ""
      while pos < str.length && /[\d\s]/.match(str[pos])
        token += str[pos] unless /\s/.match(str[pos])
        pos += 1
      end
      return [token, pos]
    end
  end
end
