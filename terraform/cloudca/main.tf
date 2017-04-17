provider "cloudca" {
  api_key = "${var.api_key}"
}

resource "cloudca_instance" node {
   environment_id = "${var.environment_id}"
   count="${var.vm_count}"
   name="${format("helm%1d", count.index + 1)}"
   network_id="${var.network_id}"
   template = "${var.image_name}"
   compute_offering = "${var.vm_flavor}"
   ssh_key_name = "${var.key_name}"
}

resource "cloudca_volume" drive_1 {
   environment_id = "${var.environment_id}"
   count = "${var.vol1_count}"
   name = "docker_${element(cloudca_instance.node.*.name, count.index)}"
   disk_offering = "${var.vol1_size}"
   instance_id   = "${element(cloudca_instance.node.*.id, count.index)}"
}

resource "cloudca_volume" drive_2 {
   environment_id = "${var.environment_id}"
   count = "${var.vol2_count}"
   name = "nfsprovisioner_${element(cloudca_instance.node.*.name, count.index)}"
   disk_offering = "${var.vol2_size}"
   instance_id   = "${element(cloudca_instance.node.*.id, count.index)}"
}
