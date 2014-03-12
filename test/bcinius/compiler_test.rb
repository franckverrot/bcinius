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
require 'helper'

describe "compiler" do
  subject      { BC::Compiler.new }
  let(:parser) { BC::Parser.new }

  it "generates code for basic literals" do
    compiled_code = subject.compile(parser.parse("42"))
    compiled_code.execute.must_equal 42

    compiled_code = subject.compile(parser.parse("4.2"))
    compiled_code.execute.must_equal 4.2
  end

  it "generate code for additions" do
    compiled_code = subject.compile(parser.parse("4+2"))
    compiled_code.execute.must_equal 6

    #compiled_code = subject.compile([4.2, BC::Addition, 2.2])
    #compiled_code.execute.must_equal 6.4
  end

  it "generate code for substractions" do
    compiled_code = subject.compile(parser.parse("4-2"))
    compiled_code.execute.must_equal 2

    compiled_code = subject.compile(parser.parse("4.2-2.2"))
    compiled_code.execute.must_equal 2.0
  end

  it "generate code for multiplications" do
    compiled_code = subject.compile(parser.parse("4*2"))
    compiled_code.execute.must_equal 8

    compiled_code = subject.compile(parser.parse("4.2*2.2"))
    compiled_code.execute.must_equal 9.240000000000002
  end

  it "generate code for divisions" do
    compiled_code = subject.compile(parser.parse("4/2"))
    compiled_code.execute.must_equal 2

    compiled_code = subject.compile(parser.parse("4.2/2.2"))
    compiled_code.execute.must_equal 1.909090909090909
  end
end
