provider "aws" {
  region = var.vpc_region
}

variable "cidr_block" {
  type = string
  description = "CIDR block to be used for VPC"
  default = "10.68.0.0/16"
}

variable "vpc_region" {
  type = string
  description = "region for VPC"
  default = "ap-southeast-2"
}

#################################################################################
# VPC Module
#################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "pluralith-demo"
  cidr = var.cidr_block

  azs             = ["${var.vpc_region}a", "${var.vpc_region}b", "${var.vpc_region}c"]
  public_subnets = [cidrsubnet(var.cidr_block, 3, 0)]
  private_subnets = [cidrsubnet(var.cidr_block, 3, 1), cidrsubnet(var.cidr_block, 3, 2), cidrsubnet(var.cidr_block, 3, 3)]

  enable_dns_hostnames   = true
  enable_dns_support     = true
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  create_igw             = true

  default_security_group_egress = [{
    cidr_blocks = "0.0.0.0/0"
  }]

  default_security_group_ingress = [{
    description = "Allow all internal traffic"
    self        = true
  }]
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "GameScores"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}


resource "aws_redshift_cluster" "example" {
  cluster_identifier = "tf-redshift-cluster"
  database_name      = "mydb"
  master_username    = "exampleuser"
  master_password    = "Seriously9ow?!"
  node_type          = "dc1.large"
  cluster_type       = "single-node"
}