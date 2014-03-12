module BC
  class Parser
    def parse(str)
      pos = 0
      unit = decimal = ""
      while pos < str.length && /\d/.match(str[pos])
        unit += str[pos]
        pos += 1
      end
      if /\./.match(str[pos])
        pos += 1
        while pos < str.length && /\d/.match(str[pos])
          decimal += str[pos]
          pos += 1
        end
      end
      if decimal.empty?
        Integer(unit)
      else
        Float("#{unit}.#{decimal}")
      end
    end
  end
end
