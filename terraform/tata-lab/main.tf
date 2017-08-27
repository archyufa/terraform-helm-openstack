provider "cloudca" {
  api_key = "${var.api_key}"
}

# Create the Public IP for Helm nodes.
resource "cloudca_public_ip" "master_ip_endpoint" {
  count          = "${var.vm_count}"
  environment_id = "${var.environment_id}"
  vpc_id         = "${var.cloudca_vpc}"
}

# cloudinit
data "template_file" "cloudinit" {
  template = "${file("./cloudinit.tpl")}"
}

# Create VM for Helm Nodes
resource "cloudca_instance" node {
   environment_id   = "${var.environment_id}"
   count            = "${var.vm_count}"
   name             = "${format("jenkins%1d", count.index + 1)}"
   network_id       = "${var.network_id}"
   template         = "${var.image_name}"
   compute_offering = "${var.vm_flavor}"
   ssh_key_name     = "${var.key_name}"
   user_data        = "${data.template_file.cloudinit.rendered}"
}

resource "cloudca_static_nat" "helmos_nat" {
   count              = "${var.vm_count}"
   environment_id     = "${var.environment_id}"
   public_ip_id       = "${element(cloudca_public_ip.master_ip_endpoint.*.id, count.index)}"
   private_ip_id      = "${element(cloudca_instance.node.*.private_ip_id, count.index)}"
}

output "node_name" {
  value = "${cloudca_instance.node.name}"
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
