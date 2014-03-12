require 'minitest/autorun'
require 'bc'

describe "BC" do
  describe "parser" do
    subject { BC::Parser.new }

    it "should recognize a number literal" do
      subject.parse("42").must_equal 42
    end
  end
end
