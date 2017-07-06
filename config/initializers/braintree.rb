require 'rails_ext/tag_helper_ext'
BraintreeRails::Configuration.environment = :sandbox
BraintreeRails::Configuration.logger = Logger.new('log/braintree.log')
BraintreeRails::Configuration.merchant_id ="vz2h4z5yqjpyzzcq"
BraintreeRails::Configuration.public_key = "nv68242kpwm4j2qk"
BraintreeRails::Configuration.private_key = "e01e8e1581d5a6c487d2f0590c5aca46"
