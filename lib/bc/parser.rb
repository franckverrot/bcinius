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
  class UnknownToken < RuntimeError ; end

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
          raise UnknownToken.new(str[pos])
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
