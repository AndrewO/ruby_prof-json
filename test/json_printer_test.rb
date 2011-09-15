require 'test/unit'
require 'ruby-debug'
require 'ruby-prof/json_printer'
require File.dirname(__FILE__) + '/prime'

class JsonPrinterTest < Test::Unit::TestCase
  def go
    run_primes(1000)
  end

  def setup
    RubyProf::measure_mode = RubyProf::WALL_TIME # WALL_TIME so we can use sleep in our test and get same measurements on linux and doze
    
    @result = RubyProf.profile do
      begin
        run_primes(1000)
        go
      rescue => e
        p e
      end
    end
  end

  def test_json_string
    assert_nothing_raised do
      output = ENV['SHOW_RUBY_PROF_PRINTER_OUTPUT'] == "1" ? STDOUT : StringIO.new('')

      printer = RubyProf::JsonPrinter.new(@result)
      printer.print(output)
    end
  end
end