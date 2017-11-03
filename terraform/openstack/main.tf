provider "openstack" {
user_name   = "admin"
tenant_name = "admin"
password    = "5a6e549678436a797d7"
auth_url    = "http://172.29.236.100:5000/v3"
region      = "RegionOne"
domain_name  = "Default"
}
## cloudinit
#data "template_file" "cloudinit" {
#  template = "${file("./cloudinit.tpl")}"
#}


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
#  user_data       = "${data.template_file.cloudinit.rendered}"
}

## Allocate floating IPs (optional)
#resource "openstack_compute_floatingip_v2" "floating_ip" {
#  count = "${var.assign_floating_ip ? var.count : 0}"
#  pool  = "${var.floating_ip_pool}"
#}

# Associate floating IPs (if created)
#resource "openstack_compute_floatingip_associate_v2" "floating_ip" {
#  count       = "${var.assign_floating_ip ? var.count : 0}"
#  floating_ip = "${element(openstack_compute_floatingip_v2.floating_ip.*.address, count.index)}"
#  instance_id = "${element(openstack_compute_instance_v2.instance.*.id, count.index)}"
#}
