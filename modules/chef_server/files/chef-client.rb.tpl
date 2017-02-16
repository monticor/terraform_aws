log_level        :info
log_location     STDOUT
chef_server_url  'https://${entry_point}/organizations/ra'
validation_client_name 'ra-validator'
validation_key '/etc/chef/ra-validator.pem'
ssl_verify_mode :verify_none
environment 'production'