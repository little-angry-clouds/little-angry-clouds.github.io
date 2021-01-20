resource "helm_release" "openebs" {
  name       = "openebs"
  chart      = "openebs"
  repository = "https://openebs.github.io/charts"
  version    = "2.4.0"
  set {
    name  = "snapshotOperator.enabled"
    value = "false"
  }
  set {
    name  = "webhook.enabled"
    value = "false"
  }
  set {
    name  = "localprovisioner.enabled"
    value = "false"
  }
}
