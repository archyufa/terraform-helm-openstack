# Core settings
variable count {}

variable name_prefix {}
variable flavor_name {}
variable flavor_id {}
variable image_name {}

# SSH settings
variable ssh_user {}

variable keypair_name {}

# Network settings
variable network_name {}

variable secgroup_name {}

variable assign_floating_ip {
  default = false
}

variable floating_ip_pool {}
