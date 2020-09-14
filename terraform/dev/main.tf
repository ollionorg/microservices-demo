resource "random_id" "this" {
  byte_length = 4
}

locals {
  random_id = random_id.this.dec
}
