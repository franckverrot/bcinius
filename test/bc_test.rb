require 'minitest/autorun'
require 'bc'

describe "BC" do
  describe "parser" do
    subject { BC::Parser.new }

    it "should recognize a number literal" do
      subject.parse("42").must_equal 42
    end

    it "should recognize a float literal" do
      subject.parse("4.2").must_equal 4.2
    end

    it "shouldn't care about extra spaces" do
      subject.parse(" 4    ").must_equal 4
      subject.parse("  4.2 ").must_equal 4.2
    end

  end
end
