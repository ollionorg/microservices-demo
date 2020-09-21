resource "google_compute_network" "network" {
  project = var.GOOGLE_PROJECT

  name                    = "${var.network_name}-${local.random_id}"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "gke" {
  project = var.GOOGLE_PROJECT
  region  = var.GOOGLE_REGION

  name                     = "${var.gke_subnet_name}-${local.random_id}"
  network                  = google_compute_network.network.id
  ip_cidr_range            = var.gke_subnet_cidr_range
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  secondary_ip_range {
    range_name    = "secondary-range-pods"
    ip_cidr_range = var.gke_subnet_cidr_range_pod
  }

  secondary_ip_range {
    range_name    = "secondary-range-services"
    ip_cidr_range = var.gke_subnet_cidr_range_services
  }
}
