# Create instances
resource "openstack_compute_instance_v2" "instance" {
  count       = "${var.count}"
  name        = "${var.name_prefix}-${format("%03d", count.index)}"
  image_name  = "${var.image_name}"
  flavor_name = "${var.flavor_name}"
  flavor_id   = "${var.flavor_id}"
  key_pair    = "${var.keypair_name}"

  network {
    name = "${var.network_name}"
  }

  security_groups = ["${var.secgroup_name}"]
  user_data       = "${data.template_file.instance_bootstrap.rendered}"
}

# Allocate floating IPs (optional)
resource "openstack_compute_floatingip_v2" "floating_ip" {
  count = "${var.assign_floating_ip ? var.count : 0}"
  pool  = "${var.floating_ip_pool}"
}

# Associate floating IPs (if created)
resource "openstack_compute_floatingip_associate_v2" "floating_ip" {
  count       = "${var.assign_floating_ip ? var.count : 0}"
  floating_ip = "${element(openstack_compute_floatingip_v2.floating_ip.*.address, count.index)}"
  instance_id = "${element(openstack_compute_instance_v2.instance.*.id, count.index)}"
}

