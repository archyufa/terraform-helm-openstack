variable "api_key" {
  description = "Your Cloud.ca API Key"
  type="string"
}

variable "environment_id"{
  description = "Your Cloud.ca environement ID"
  type="string"
}

variable "key_name"{
  description = "Your Cloud.ca ssh key pair key"
  type="string"
}

variable cloudca_vpc {
  description = "VPC used for this environment"
  type="string"
}

#OpenStack Helm nodes variables
variable vm_count {
  description = "Number of Workshop VMs"
  default     = 0
}

variable network_id {
  description = "Standard Tier Network ID"
  type="string"
}

variable image_name {
  description = "Base OS for VMs running K8s"
  default     = "Ubuntu 16.04.02 HVM"
}

variable vm_flavor {
  description = "Size of VMs running K8s Master"
  default     = "4vCPU.16GB"
}

#STORAGE 
variable root_size {
  description = "Size of VMs running K8s Master"
  default     = "50"

}
