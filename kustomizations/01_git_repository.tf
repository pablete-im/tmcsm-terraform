# Create Tanzu Mission Control git repository with attached set as default value.
resource "tanzu-mission-control_git_repository" "git_repository" {
  name = "ns-kustomizations-repo" # Required

  namespace_name = "tanzu-continuousdelivery-resources" #Required

  depends_on = [tanzu-mission-control_repository_credential.git_credential]

  scope {
    cluster {
      name                    = var.cluster_name # Required
      provisioner_name        = var.provisioner    # Default: attached
      management_cluster_name = var.management_cluster    # Default: attached
    }
  }

  meta {
    description = "Create Git Repository through terraform"
    labels      = { "key" : "value" }
  }

  spec {
    url                = var.git_repo_url
    secret_ref         = tanzu-mission-control_repository_credential.git_credential.name
    interval           = "5m"    # Default: 5m
    git_implementation = "GO_GIT" # Default: GO_GIT
    ref {
      branch = var.git_repo_branch
    }
  }
}