output "network" {
  value = google_compute_network.network
}

output "gke_subnetwork" {
  value = google_compute_subnetwork.gke
}

output "gke" {
  value = module.gke
}
