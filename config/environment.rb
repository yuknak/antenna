# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# For Passenger bug on Windows Subsystem for Linux (WSL)
if /microsoft/i =~ File.open('/proc/version')&.read
  ENV['_PASSENGER_FORCE_HTTP_SESSION'] = "true"
end