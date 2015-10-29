require 'brakeman'
tracker = Brakeman.run app_path: "", quiet: false

puts tracker.report
if tracker.filtered_warnings.length === 0
  puts "Brakeman did not find any new vulnerabilities."
else
  tracker.filtered_warnings.each { |warn|
    puts warn
  }
  raise "Brakeman found vulnerabilities!!!!"
end