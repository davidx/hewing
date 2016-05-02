require 'apachelogregex'
require 'date'
require 'yaml'
require 'user_agent_parser'


module Hewing
  VERSION=0.1

  class Log
    attr_reader(:file_path)
    def initialize(file_path)
      @file_path = file_path
    end
    def generate_report
      report={}
      agent_parser = UserAgentParser::Parser.new
      IO.foreach(file_path) do |line|
        line_hash = parse_line(line)
        timestamp = line_hash["%t"]
        stamp = timestamp.sub(/:/, ' ')
        date = DateTime.parse( stamp ).strftime("%Y-%m-%d")
        request_method = line_hash["%r"].split(/\s/).shift
        user_agent = agent_parser.parse line_hash["%{User-Agent}i"]
        request_os = user_agent.os.to_s

        unless report.key?(date)
          report[date]={"total_requests"=> 0, "agents" => {}, "os" => {} }
        end
        unless report[date]["os"].key?(request_os)
          report[date]["os"][request_os] = { "GET" => 0, "POST" => 0, "HEAD" => 0, "PUT" => 0}
        end
        report[date]["total_requests"] += 1
        report[date]["os"][request_os][request_method] += 1

        unless report[date]["agents"].key?(user_agent.to_s)
          report[date]["agents"][user_agent.to_s] = 0
        end
        report[date]["agents"][user_agent.to_s] += 1
      end

      report.keys.each do |date|
        sorted_agents = report[date]["agents"].sort_by {|user_agent, count| count}.reverse.slice(0,3)
        report[date]["agents"] = sorted_agents.collect{|agent,count| {agent => count} }
        report[date]["os"].keys.each do |os|
           total = report[date]["os"][os].values.inject(0, &:+)
           report[date]["os"][os].keys.each do |request_method|
             count = report[date]["os"][os][request_method]
             report[date]["os"][os][request_method] = "#{count.percent_of(total).to_f.round(2)}%"
           end
         end
      end

      report
    end

    def parse_line(line)
      format = '%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"'
      parser = ApacheLogRegex.new(format)
      parser.parse(line)
    end
  end

  def open_logfile(file_path)
    Hewing::Log.new(file_path)
  end
end

class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end
