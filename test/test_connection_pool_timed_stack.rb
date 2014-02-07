Thread.abort_on_exception = true
require 'helper'

class TestConnectionPoolTimedStack < Minitest::Test

  def setup
    @stack = ConnectionPool::TimedStack.new { Object.new }
  end

  def test_push
    assert_empty @stack

    @stack.push Object.new

    refute_empty @stack
  end

  def test_pop
    e = assert_raises Timeout::Error do
      @stack.pop 0.0000001
    end

    assert_match %r%Waited [\de.-]+ sec%, e.message
  end

end

