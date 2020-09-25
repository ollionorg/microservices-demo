resource "google_project_service" "this" {
  count   = length(var.services)
  project = var.GOOGLE_PROJECT
  service = var.services[count.index]

  disable_on_destroy = false
}
