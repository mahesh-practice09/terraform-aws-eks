data "aws_ssm_parameter" "mysql_sg_id" {
  
  name = "/${var.Project}/${var.environment}/mysql_sg_id"
}

data "aws_ssm_parameter" "db_subnet_group_name" {
  name  = "/${var.Project}/${var.environment}/db_subnet_group_name" 
}