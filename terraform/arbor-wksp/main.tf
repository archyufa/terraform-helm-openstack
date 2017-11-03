provider "cloudca" {
  api_key                 = "${var.api_key}"
}

# Create the Public IP for Helm nodes.
resource "cloudca_public_ip" "master_ip_endpoint" {
  count                   = "${var.vm_count}"
  environment_id          = "${var.environment_id}"
  vpc_id                  = "${var.cloudca_vpc}"
}

# cloudinit
data "template_file" "cloudinit" {
  template = "${file("./cloudinit.tpl")}"
}

# Create VM for Workshop Nodes
resource "cloudca_instance" node {
   environment_id         = "${var.environment_id}"
   count                  = "${var.vm_count}"
   name                   = "${format("arbor%1d", count.index + 1)}"
   network_id             = "${var.network_id}"
   template               = "${var.image_name}"
   compute_offering       = "${var.vm_flavor}"
   ssh_key_name           = "${var.key_name}"
   user_data              = "${data.template_file.cloudinit.rendered}"
   root_volume_size_in_gb = "${var.root_size}"
}

resource "cloudca_static_nat" "_nat" {
   count                  = "${var.vm_count}"
   environment_id         = "${var.environment_id}"
   public_ip_id           = "${element(cloudca_public_ip.master_ip_endpoint.*.id, count.index)}"
   private_ip_id          = "${element(cloudca_instance.node.*.private_ip_id, count.index)}"
}

output "node_name" {
  value                   = "${cloudca_instance.node.name}"
}
