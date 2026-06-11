data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.Project}/${var.environment}/vpc"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.Project}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "eks_control_plane_sg_id" {
  
  name = "/${var.Project}/${var.environment}/eks_control_plane_sg_id"
}

data "aws_ssm_parameter" "eks_node_sg_id" {
  
  name = "/${var.Project}/${var.environment}/eks_node_sg_id"
}