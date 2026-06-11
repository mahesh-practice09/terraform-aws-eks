module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.Project}-${var.environment}-mysql"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20

  db_name  = "cities"
  username = "root"
  port     = "3306"
  manage_master_user_password = false
  password_wo = "RoboShop#123"
  password_wo_version = 1

  iam_database_authentication_enabled = false

  vpc_security_group_ids = [ data.aws_ssm_parameter.mysql_sg_id.value ]

  # DB subnet group
  create_db_subnet_group = false
  db_subnet_group_name = data.aws_ssm_parameter.db_subnet_group_name.value

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

   tags = merge(
    {
      Name = "${var.Project}-${var.environment}-dbsubnetgrp",
    },
    local.common_tags
  )

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}

