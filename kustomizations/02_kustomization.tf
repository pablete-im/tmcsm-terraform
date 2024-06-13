# Create Tanzu Mission Control kustomization with attached set as default value.
resource "tanzu-mission-control_kustomization" "cluster_kustomization" {
  name = "namespace-settings-kustomization" # Required

  namespace_name = "ipablo-ns" #Required

  depends_on = [tanzu-mission-control_git_repository.git_repository]

  scope {
    cluster {
      name                    = var.cluster_name
      provisioner_name        = var.provisioner
      management_cluster_name = var.management_cluster
    }
  }

  meta {
    description = "Create Flux Kustomization through terraform"
    labels      = { "key" : "value" }
  }

  spec {
    path             = var.git_repo_kustomization_path
    prune            = "true"
    interval         = "5m" # Default: 5m
    target_namespace = "ipablo-ns"
    source {
      name      = tanzu-mission-control_git_repository.git_repository.name      # Required
      namespace = tanzu-mission-control_git_repository.git_repository.namespace_name # Required
    }
  }
}