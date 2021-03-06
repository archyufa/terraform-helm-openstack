# Create a new tag
resource "digitalocean_tag" "cluster_tag" {
  name = "${var.cluster_tag}"
}

# Upload SSH key which all instances will use.
resource "digitalocean_ssh_key" "default" {
  name       = "SSH Key for Terraform"
  public_key = "${file("${path.module}/../ssh/cluster.pem.pub")}"
}

# Create the K8s node
resource "digitalocean_droplet" "master_nodes" {
  count              = "${var.master_count}"
  image              = "${var.image}"
  name               = "${format("kube%1d", count.index + 1)}"
  region             = "${var.region}"
  size               = "${var.droplet_size}"
  ssh_keys           = ["${digitalocean_ssh_key.default.id}"]
  tags               = ["${digitalocean_tag.cluster_tag.id}"]
  private_networking = true

  connection {
    type        = "ssh"
    private_key = "${file("${path.module}/../ssh/cluster.pem")}"
    user        = "ubuntu"
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "provision.sh"
    destination = "/tmp/provision.sh"
  }

}

