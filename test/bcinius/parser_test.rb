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

describe "parser" do
  subject { BC::Parser.new }

  it "should recognize a number literal" do
    subject.parse("42").must_equal [42]
  end

  it "should recognize a float literal" do
    subject.parse("4.2").must_equal [4.2]
  end

  it "shouldn't care about extra spaces" do
    subject.parse(" 4    ").must_equal [4]
    subject.parse("  4.2 ").must_equal [4.2]
  end

  it "should recognize an addition operation" do
    subject.parse("4+2").must_equal [4, BC::Addition, 2]
  end

  it "should recognize an substraction operation" do
    subject.parse("4-2").must_equal [4, BC::Substraction, 2]
  end

  it "should recognize an multiplication operation" do
    subject.parse("4*2").must_equal [4, BC::Multiplication, 2]
  end

  it "should recognize an division operation" do
    subject.parse("4/2").must_equal [4, BC::Division, 2]
  end
end
