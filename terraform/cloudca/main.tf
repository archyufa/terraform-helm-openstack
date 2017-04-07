provider "cloudca" {
  api_key = "${var.api_key}"
}

resource "cloudca_instance" lab-1 {
   environment_id = "${var.environment_id}"
   name="lab-1"
   network_id="fe2fbac4-1c2e-4dd6-8095-e4e2156f7d8a"
   template = "Ubuntu 16.04.01 HVM"
   compute_offering = "2vCPU.8GB"
   ssh_key_name = "${var.key_name}"
}

resource "cloudca_volume" drive_1 {
   environment_id = "${var.environment_id}"
   name = "drive_1"
   disk_offering = "20GB - 20 IOPS Min."
   instance_id="${cloudca_instance.lab-1.id}"
}

resource "cloudca_volume" drive_2 {
   environment_id = "${var.environment_id}"
   name = "drive_2"
   disk_offering = "20GB - 20 IOPS Min."
   instance_id="${cloudca_instance.lab-1.id}"
}
