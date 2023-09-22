require 'sinatra'
require 'pry'

set :bind, '0.0.0.0'
set :port, 8080


require "splunk/otel"
Splunk::Otel.configure(auto_instrument: true)

## This one doesn't work either:
#Splunk::Otel.configure do |c|
#  c.use 'OpenTelemetry::Instrumentation::Sinatra'
#end

## Upstream works:
#require 'opentelemetry/sdk'
#require 'opentelemetry/exporter/otlp'
#require 'opentelemetry/instrumentation/all'
#OpenTelemetry::SDK.configure do |c|
#  c.service_name = 'private-isu'
#  c.use_all() # enables all instrumentation!
#end



get '/' do
  @cats = rand(100)
  html = haml :index
# Look into `OpenTelemetry::Trace.current_span` here: 
  binding.pry
  html
end

__END__
@@index
%html
  <head><title>Hello World</title></head>
  %body
    %p I have #{@cats} cat#{:s unless @cats==1}!
