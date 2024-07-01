resource "tanzu-mission-control_mutation_policy" "cluster_group_label_mutation_policy" {
  name = "namespace-mutation-test"

  scope {
    cluster_group {
      cluster_group = var.cluster_group
    }
  }

  spec {
    input {
      label {
        target_kubernetes_resources {
          api_groups = [
            "",
          ]
          kinds = [
            "Namespace",
          ]
        }
        scope = "*"
        label {
          key   = "pod-security.kubernetes.io/enforce"
          value = "privileged"
        }
      }
    }
  }
}
