# This is the Variables file. 

variable "environment" {
  type             = "string"
  description      = "SDLC Environment"
  default          = "Prod"
}

variable "aws_region" {
  type             = "string"
  description      = "AWS Region to deploy to"
  default          = "us-east-1"
}

# AMI mapping
#
variable "ami_map" {
  type             = "map"
  description      = "AMI map of OS/region (2016-03-14)"
  default          = {
    centos7-us-east-1       = "ami-6d1c2007"
    centos7-us-west-2       = "ami-d2c924b2"
    centos7-us-west-1       = "ami-af4333cf"
    centos7-eu-central-1    = "ami-9bf712f4"
    centos7-eu-west-1       = "ami-7abd0209"
    centos7-ap-southeast-1  = "ami-f068a193"
    centos7-ap-southeast-2  = "ami-fedafc9d"
    centos7-ap-northeast-1  = "ami-eec1c380"
    centos7-ap-northeast-2  = "ami-c74789a9"
    centos7-sa-east-1       = "ami-26b93b4a"

    ubuntu16-us-east-1      = "-1"
    ubuntu16-us-west-2      = "-1"
    ubuntu16-us-west-1      = "-1"
    ubuntu16-eu-central-1   = "-1"
    ubuntu16-eu-west-1      = "-1"
    ubuntu16-ap-southeast-1 = "-1"
    ubuntu16-ap-southeast-2 = "-1"
    ubuntu16-ap-northeast-1 = "-1"
    ubuntu16-ap-northeast-2 = "-1"
    ubuntu16-sa-east-1      = "-1"

    ubuntu14-us-east-1      = "ami-4f0c4758"
    ubuntu14-us-west-2      = "ami-f319c293"
    ubuntu14-us-west-1      = "ami-38004858"
    ubuntu14-eu-central-1   = "ami-7cef1113"
    ubuntu14-eu-west-1      = "ami-74692b07"
    ubuntu14-ap-southeast-1 = "ami-af4fe8cc"
    ubuntu14-ap-southeast-2 = "ami-233b0940"
    ubuntu14-ap-northeast-1 = "ami-a0865cc1"
    ubuntu14-ap-northeast-2 = "-1"
    ubuntu14-sa-east-1      = "ami-72cb561e"

    ubuntu12-us-east-1      = "ami-88dfdee2"
    ubuntu12-us-west-2      = "ami-1a977e7a"
    ubuntu12-us-west-1      = "ami-4f285a2f"
    ubuntu12-eu-central-1   = "ami-3cf61153"
    ubuntu12-eu-west-1      = "ami-65932916"
    ubuntu12-ap-southeast-1 = "ami-26e32845"
    ubuntu12-ap-southeast-2 = "ami-d54e6eb6"
    ubuntu12-ap-northeast-1 = "ami-f2afa79c"
    ubuntu12-ap-northeast-2 = "-1"
    ubuntu12-sa-east-1      = "ami-2661ec4a"
  }
}

variable "instance_flavor" {
  type             = "string"
  description      = "EC2 instance flavor (type). Default: t2.medium"
  default          = "t2.medium"
}

variable "aws_network" {
  type             = "map"
  description      = "AWS networking settings"
  default          = {
    subnet         = ""
    vpc            = ""
  }
}

variable "instance_key" {
  type             = "map"
  description      = "EC2 instance SSH key settings"
  default          = {
    file           = ""
    name           = ""
  }
}

variable "instance" {
  type             = "map"
  description      = "EC2 instance host settings"
  default          = {
    domain         = "bnysecurities.corp.local"
    hostname       = "chef-server-prod"
  }
}
variable "ami_usermap" {
  type             = "map"
  description      = "Default username map for AMI selected"
  default          = {
    centos7        = "centos"
    centos6        = "centos"
    ubuntu16       = "ubuntu"
    ubuntu14       = "ubuntu"
    ubuntu12       = "ubuntu"
  }
}

variable "ami_os" {
  type             = "string"
  description      = "Chef server OS (options: centos7, [centos6], ubuntu16, ubuntu14)"
  default          = "centos7"
}
variable "allowed_cidrs" {
  type             = "string"
  description      = "List of CIDRs to allow SSH from (CSV list allowed)"
  default          = "0.0.0.0/0"
}
variable "instance_tag_desc" {
  type             = "string"
  description      = "EC2 instance description tag"
  default          = "Created using Terraform (tf_chef_server)"
}
variable "tag_contact" {
  type             = "string"
  description      = "EC2 instance description tag"
  default          = "bgilbert@convergex.com"
}
# Remove for Private Subnets
variable "instance_public" {
  #type             = "boolean"
  description      = "Associate a public IP to the instance"
  default          = "true"
}

