terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.50"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = ["subnet-04ce28d1571607d1e", "subnet-02dd0dd07bbc9cc7a"]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_rds_cluster" "default" {
  engine               = "aurora-mysql"
  engine_version       = "5.7.mysql_aurora.2.10.2"
  cluster_identifier   = "aurora-cluster-demo"
  availability_zones   = ["ap-northeast-2a", "ap-northeast-2c"]
  master_username      = "foo"
  master_password      = "password123"
  database_name        = "example_db"
  db_subnet_group_name = aws_db_subnet_group.default.id
  skip_final_snapshot  = true
}

resource "aws_rds_cluster_instance" "default" {
  engine               = aws_rds_cluster.default.engine
  engine_version       = aws_rds_cluster.default.engine_version
  identifier           = "test-primary-cluster-instance"
  cluster_identifier   = aws_rds_cluster.default.id
  instance_class       = "db.r4.large"
  db_subnet_group_name = aws_db_subnet_group.default.id
}