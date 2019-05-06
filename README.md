# README

## Smart Pension Log Processor

This is a sample ruby application which receives a filename and parses it to produce the following:

- Page views ordered volume
- Unique page views ordered by volume.

A sample file is in the folder spec/samples.

# Using the processor

- ./parser.rb <<filename>>

- `./parser.rb spec/samples/webserver.log`

# Steps to running tests

- bundle install
- rspec spec

# Known issues

- This is not an API, therefore i have not handled errors to return API compliant errors. Default errors are returned. However, required parameters are validated.

- coverage folder had been checked in deliberately so you can see the coverage

# Application other details

- Ruby version
  2.6.0
