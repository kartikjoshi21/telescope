variable "json_input" {
  description = "value of the json input"
  type = object({
    region         = string
    az             = string
    instance_type  = string
    job_id         = string
    user_data_path = string
    owner          = string
  })
}

variable "scenario_name" {
  description = "Name of the scenario"
  type        = string
  default     = ""
}

variable "deletion_delay" {
  description = "Time duration after which the resources can be deleted (e.g., '1h', '2h', '4h')"
  type        = string
  default     = "2h"
}

variable "network_config_list" {
  description = "Configuration for creating the server network."
  type = list(object({
    role                   = string
    vpc_name               = string
    vpc_cidr_block         = string
    subnet_names           = list(string)
    subnet_cidr_block      = list(string)
    security_group_name    = string
    route_table_cidr_block = string
    sg_rules = object({
      ingress = list(object({
        from_port  = number
        to_port    = number
        protocol   = string
        cidr_block = string
      })),
      egress = list(object({
        from_port  = number
        to_port    = number
        protocol   = string
        cidr_block = string
      }))
    })
  }))
}

variable "loadbalancer_config_list" {
  description = "List of Loadbalancer configurations"
  type = list(object({
    role               = string
    vpc_name           = string
    subnet_name        = string
    load_balancer_type = string
    lb_target_group = list(object({
      role       = string
      tg_suffix  = string
      port       = number
      protocol   = string
      rule_count = number
      vpc_name   = string
      health_check = object({
        port                = number
        protocol            = string
        interval            = number
        timeout             = number
        healthy_threshold   = number
        unhealthy_threshold = number
      })
      lb_listener = object({
        port     = number
        protocol = string
      })
      lb_target_group_attachment = object({
        vm_name = string
        port    = number
      })
    }))
  }))
}

variable "vm_config_list" {
  description = "List of configuration for virtual machines"
  type = list(object({
    vm_name                     = string
    role                        = string
    network_role                = string
    subnet_name                 = string
    security_group_name         = string
    associate_public_ip_address = bool
  }))
}
