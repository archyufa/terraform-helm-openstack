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
  description = "Number of Helm Openstack VMs"
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

#STORAGE part
variable vol1_count {
  description = "Number of volumes for Storage VM"
  default     = 0
}

variable vol1_size {
  description = "Size of Volumes for Persistant Storage"
  default     = "20GB - 20 IOPS Min."
}

variable vol2_count {
  description = "Number of volumes for Storage VM"
  default     = 0
}

variable vol2_size {
  description = "Size of Volumes for Persistant Storage"
  default     = "50GB - 250 IOPS Min."
}
