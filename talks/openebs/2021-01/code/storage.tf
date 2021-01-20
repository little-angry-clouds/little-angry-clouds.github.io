resource "kubernetes_manifest" "storage_pool" {
  depends_on = [helm_release.openebs]
  provider   = kubernetes-alpha
  manifest = {
    "apiVersion" = "openebs.io/v1alpha1"
    "kind"       = "StoragePool"
    "metadata" = {
      "name" = "openebs-jiva-poc"
    }
    "spec" = {
      "path" = "/mnt/openebs/"
    }
  }
}

resource "kubernetes_manifest" "storage_class" {
  depends_on = [kubernetes_manifest.storage_pool]
  provider   = kubernetes-alpha
  manifest = {
    "apiVersion" = "storage.k8s.io/v1"
    "kind"       = "StorageClass"
    "metadata" = {
      "name" = "openebs-jiva-poc"
      "annotations" = {
        "openebs.io/cas-type"   = "jiva"
        "cas.openebs.io/config" = <<EOT
- name: ReplicaCount
  value: "1"
- name: StoragePool
  value: openebs-jiva-poc
EOT
      }
    }
    "provisioner" = "openebs.io/provisioner-iscsi"
  }
}
