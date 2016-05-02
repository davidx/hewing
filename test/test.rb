require 'dust'
$:.unshift(File.join(File.dirname(__FILE__),'/../lib'))
require 'hewing'
include Hewing

SAMPLE_LOG_FILE=File.join(File.dirname(__FILE__), '/data/sample.log')
SAMPLE_DATE='2011-12-03'
SAMPLE_REPORT = open_logfile(SAMPLE_LOG_FILE).generate_report

unit_tests do

  test "can open log" do
    assert respond_to?(:open_logfile)
    log = open_logfile(SAMPLE_LOG_FILE)
    assert log.kind_of?(Hewing::Log)
  end
  test "can generate report" do
    log = open_logfile(SAMPLE_LOG_FILE)
    assert log.respond_to?(:generate_report)
    report = log.generate_report
    assert report.key?(SAMPLE_DATE)
  end
  test "report includes number of requests served by day" do
    assert SAMPLE_REPORT[SAMPLE_DATE].key?("total_requests")
    assert_equal 604, SAMPLE_REPORT[SAMPLE_DATE]["total_requests"].to_i
  end
  test "report includes 3 most frequent user agents by day" do
    assert SAMPLE_REPORT[SAMPLE_DATE].key?("agents")
    agents = SAMPLE_REPORT[SAMPLE_DATE]["agents"]
    assert agents.first.key?("Googlebot 2.1")
    assert agents.length == 3
  end
  test "report includes ratio of gets to posts by os by day" do
    assert SAMPLE_REPORT[SAMPLE_DATE].key?("os")
    assert_equal "100.0%", SAMPLE_REPORT[SAMPLE_DATE]["os"]["Linux"]["GET"]
    assert_equal "0.0%", SAMPLE_REPORT[SAMPLE_DATE]["os"]["Linux"]["POST"]
    assert_equal "0.0%", SAMPLE_REPORT[SAMPLE_DATE]["os"]["Linux"]["PUT"]

  end

end
