require "ruby-prof"
require 'json/pure'

module RubyProf
  class JsonPrinter < AbstractPrinter
    attr_reader :threads
    def initialize(result)
      super(result)
      @threads = {
        :overall_time => 0, # TODO
        :threads => result.threads.keys.map {|thread_id| thread_info(thread_id) }
      }
    end
    
    def print(output = STDOUT, options = {})
      output.puts JSON.pretty_generate(@threads)
    end
    
    private
    def thread_info(thread_id)
      {
        :thread_id => thread_id,
        :methods => @result.threads[thread_id].sort.reverse.map {|method| method_info(method) }
      }
    end
    
    def method_info(method)
      time_info(method).merge(
        location_info(method)
      ).merge(
        :parents => method.aggregate_parents.find_all {|caller| caller.parent}.sort_by(&:total_time).map {|caller| 
          time_info(caller).merge(location_info(caller.parent.target))
        },
        :children => method.aggregate_children.sort_by(&:total_time).reverse.map {|child|
          time_info(child).merge(location_info(child.target))
        }
      )
    end
    
    def time_info(method_or_call)
      {
        :called => method_or_call.called,
        :self_time => method_or_call.self_time,
        :total_time => method_or_call.total_time,
        :wait_time => method_or_call.wait_time
      }
    end

    def location_info(method)
      {
        :class => method.klass_name,
        :method => method.method_name,
        :source_file => method.source_file,
        :line => method.line
      }
    end
  end
end