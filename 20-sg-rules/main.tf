# Bastion
resource "aws_security_group_rule" "internet_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks       = ["0.0.0.0/0"]
  cidr_blocks = ["${local.my_ip}/32"]
  # which SG you are creating this rule
  security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}

# MongoDB
resource "aws_security_group_rule" "bastion_mongodb" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.mongodb_sg_id.value
}

# Redis
resource "aws_security_group_rule" "bastion_redis" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.redis_sg_id.value
}

# MySQL
resource "aws_security_group_rule" "bastion_mysql" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.mysql_sg_id.value
}


# RabbitMQ
resource "aws_security_group_rule" "bastion_rabbitmq" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
}


# Frontend
resource "aws_security_group_rule" "bastion_ingressalb" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.ingressalb_sg_id.value
}


# Frontend ALB
resource "aws_security_group_rule" "public_ingress_alb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_ssm_parameter.ingress_alb_sg_id.value
}

#openvpn

resource "aws_security_group_rule" "https_openvpn" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_ssm_parameter.openvpn_sg_id.value
}

resource "aws_security_group_rule" "ssh_openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_ssm_parameter.openvpn_sg_id.value
}


#AdminUI
resource "aws_security_group_rule" "port943_openvpn" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_ssm_parameter.openvpn_sg_id.value
}

#eks_cluster_node

resource "aws_security_group_rule" "bastion_eks_control_plane" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.eks_control_plane_sg_id.value
}

#eks_node to ekscluster

resource "aws_security_group_rule" "eks_control_plane_eks_node" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"  #alltraffic
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.eks_control_plane_sg_id.value
  security_group_id = data.aws_ssm_parameter.eks_node_sg_id.value
}

resource "aws_security_group_rule" "eks_node_eks_control_plane" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.eks_node_sg_id.value
  security_group_id = data.aws_ssm_parameter.eks_control_plane_sg_id.value
}

resource "aws_security_group_rule" "eks_node_vpc_cidr" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["10.0.0.0/16"]
  security_group_id = data.aws_ssm_parameter.eks_node_sg_id.value
}

resource "aws_security_group_rule" "bastion_eks_node" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.eks_node_sg_id.value
}