

  variable "project" {
    default = "roboshop"
  }

  variable "environment" {
    default = "sbx"
  }

  # variable "Component" {
  #   default = "Mongodb"
  # }

  variable "Component" {
    type = list 
    default = [
       #databases
       "mongodb" , "redis" ,"mysql" , "rabbitmq",
      #ALB
      "ingress_alb", "bastion" , "openvpn",
      "eks_control_plane" , "eks_node"
    ]
  }