module "chef_server" {
  source = "github.com/monticor/tf_chef_server.git"
  #aws = {}
  
  aws_network = {
    subnet = "subnet-d00ed9fd"
    vpc    = "vpc-2bf5f74c"
  }
  #chef_license = "true"
  #chef_ssl = {
  #  cert = "SSL_CERTIFICATE"
  # key  = "SSL_CERTIFICATE_KEY"
  #}
  instance_key = {
    file = "/tmp/bg.pem"
    name = "bg"
  }
}