# require 'rails_ext/tag_helper_ext'
Braintree::Configuration.logger = Logger.new('log/braintree.log')
Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id ="vz2h4z5yqjpyzzcq"
Braintree::Configuration.public_key = "nv68242kpwm4j2qk"
Braintree::Configuration.private_key = "e01e8e1581d5a6c487d2f0590c5aca46"
