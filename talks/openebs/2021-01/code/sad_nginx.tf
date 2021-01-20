// Está triste por que usará gp2 en vez de openebs
resource "kubernetes_stateful_set" "nginx_triste" {
  metadata {
    name = "openebs-poc-nginx-triste"
    labels = {
      app    = "nginx"
      estado = "triste"
    }
  }
  spec {
    service_name = "nginx"
    replicas     = 1
    selector {
      match_labels = {
        app    = "nginx"
        estado = "triste"
      }
    }
    template {
      metadata {
        labels = {
          app    = "nginx"
          estado = "triste"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "nginx"
          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 3
            period_seconds        = 3
          }
          volume_mount {
            name       = "data"
            mount_path = "/data"
          }
        }
      }
    }
    volume_claim_template {
      metadata {
        name = "data"
      }
      spec {
        access_modes       = ["ReadWriteOnce"]
        storage_class_name = "gp2"
        resources {
          requests = {
            storage = "5Gi"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx_triste" {
  metadata {
    name = "openebs-poc-nginx-triste"
  }
  spec {
    selector = {
      app    = "openebs-poc-nginx"
      estado = "triste"
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}
