provider "google" {
  region  = "${var.region}"
  project = "${var.project_id}"
}

data "google_compute_image" "image" {
  project = "${var.project_id}"
  family  = "consul"
}

module "consul_cluster" {
  # Use version v0.0.1 of the consul-cluster module
  source = "git@github.com:hashicorp/terraform-google-consul.git//modules/consul-cluster?ref=v0.3.1"

  # Specify either the Google Image "family" or a specific Google Image. You should build this using the scripts
  # in the install-consul module.
  source_image = "${data.google_compute_image.image.name}"

  # Add this tag to each node in the cluster
  cluster_tag_name = "consul-cluster"

  # Configure and start Consul during boot. It will automatically form a cluster with all nodes that have that
  # same tag. 
  startup_script = <<-EOF
              #!/bin/bash
              /opt/consul/bin/run-consul --server --cluster-tag-name consul-cluster
              EOF

  machine_type   = "n1-standard-1"
  cluster_size   = "3"
  gcp_project_id = "${var.project_id}"
  gcp_region     = "${var.region}"
  cluster_name   = "consul-demo"
}
