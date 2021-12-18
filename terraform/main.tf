terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

provider "openstack" {
  auth_url    = "http://controller:5000/v3"
  region      = "RegionOne"
}

resource "openstack_networking_secgroup_v2" "secgroup" {
  name        = "workstation secgroup"
  description = "allow all traffic"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_ingress_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = ""
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}

resource "openstack_compute_instance_v2" "workstation" {
  name            = var.name
  image_id        = "7b84e04c-a7e2-4349-8bfe-b63f85502cb3"
  flavor_id       = "7a1c6bb9-3afe-4579-b448-0ef4cad83057"
  key_pair        = var.key_pair
  security_groups = [ openstack_networking_secgroup_v2.secgroup.name ]

  metadata = {
    this = "that"
  }

  network {
    name = var.network
  }

  user_data = "${file("script.sh")}"  
}

resource "openstack_blockstorage_volume_v3" "workstation" {
  region      = "RegionOne"
  name        = "workstation_volume_1"
  size        = 40
}

resource "openstack_compute_volume_attach_v2" "workstation" {
  instance_id = "${openstack_compute_instance_v2.workstation.id}"
  volume_id   = "${openstack_blockstorage_volume_v3.workstation.id}"
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "provider"
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.workstation.id}"
}

output "floating_ip_addr" {
  value = openstack_networking_floatingip_v2.fip_1.address
}

