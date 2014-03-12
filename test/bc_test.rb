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

    it "generates code for basic literals" do
      compiled_code = subject.compile([42])
      compiled_code.execute.must_equal 42

      compiled_code = subject.compile([4.2])
      compiled_code.execute.must_equal 4.2
    end

    it "generate code for additions" do
      compiled_code = subject.compile([4, BC::Addition, 2])
      compiled_code.execute.must_equal 6

      compiled_code = subject.compile([4.2, BC::Addition, 2.2])
      compiled_code.execute.must_equal 6.4
    end

    it "generate code for substractions" do
      compiled_code = subject.compile([4, BC::Substraction, 2])
      compiled_code.execute.must_equal 2

      compiled_code = subject.compile([4.2, BC::Substraction, 2.2])
      compiled_code.execute.must_equal 2.0
    end

    it "generate code for multiplications" do
      compiled_code = subject.compile([4, BC::Multiplication, 2])
      compiled_code.execute.must_equal 8

      compiled_code = subject.compile([4.2, BC::Multiplication, 2.2])
      compiled_code.execute.must_equal 9.240000000000002
    end

    it "generate code for divisions" do
      compiled_code = subject.compile([4, BC::Division, 2])
      compiled_code.execute.must_equal 2

      compiled_code = subject.compile([4.2, BC::Division, 2.2])
      compiled_code.execute.must_equal 1.909090909090909
    end

    it "won't generate code for unknown operation" do
      assert_raises(BC::UnknownOperator) do
        compiled_code = subject.compile([4, nil, 2])
        compiled_code.execute.must_equal nil
      end

      assert_raises(BC::UnknownOperator) do
        compiled_code = subject.compile([4.2, nil, 2.2])
        compiled_code.execute.must_equal nil
      end
    end
  end
end
