module "gke" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id = var.project_id

  name = var.gke_name

  regional = false
  region   = var.region
  zones    = [var.zone]

  network    = module.vpc.network_name
  subnetwork = module.vpc.subnets["${var.region}/${var.gke_subnet_name}"].name

  ip_range_pods     = "secondary-range-pods"
  ip_range_services = "secondary-range-services"

  create_service_account = false
  service_account        = null

  enable_private_endpoint = false
  enable_private_nodes    = true

  master_ipv4_cidr_block = var.gke_cidr_range_master

  master_authorized_networks = [
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "Public"
    },
  ]

  remove_default_node_pool = true

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
      min_count          = 1
      max_count          = 10
      local_ssd_count    = 0
      disk_size_gb       = 20
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = null
      preemptible        = true
      initial_node_count = 1
    },
  ]
}
