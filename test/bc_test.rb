require 'minitest/autorun'
require 'bc'

describe "BC" do
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

  describe "compiler" do
    subject { BC::Compiler.new }

    it "can produce bytecode executables" do
      compiled_code = subject.compile([42])
      compiled_code.execute.must_equal 42

      compiled_code = subject.compile([4.2])
      compiled_code.execute.must_equal 4.2
    end
  end
end
