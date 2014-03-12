module BC
  class Addition; end
  class Substraction; end
  class Multiplication; end
  class Division; end

  class Parser
    def parse(input)
      decimal = ""
      pos = 0
      tokens = Array.new
      str = input.gsub(' ', '')

      while pos < str.length
        case str[pos]
        when /\d/
          # parse units
          unit, pos = consume_number_literal(str, pos)

          # parse decimals
          if /\./.match(str[pos])
            pos += 1
            decimal, pos = consume_number_literal(str, pos)
          end

          # return value
          if decimal.empty?
            tokens.push Integer(unit)
          else
            tokens.push Float("#{unit}.#{decimal}")
          end
        when /\+/
          tokens.push(Addition)
          pos += 1
        when /-/
          tokens.push(Substraction)
          pos += 1
        when /\*/
          tokens.push(Multiplication)
          pos += 1
        when /\//
          tokens.push(Division)
          pos += 1
        else
          pos += 1
        end
      end
      tokens
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
