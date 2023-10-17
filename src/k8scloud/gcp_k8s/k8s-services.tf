# Terraform google cloud multi tier Kubernetes deployment

#################################################################
# Definition of the Services
#################################################################

resource "kubernetes_service" "potato-service" {
  metadata {
    name = "potato-service"
  }
  spec {
    selector = {
      app = "potato-service"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_service" "beverage-service" {
  metadata {
    name = "beverage-service"
  }
  spec {
    selector = {
      app = "beverage-service"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_service" "popcorn-service" {
  metadata {
    name = "popcorn-service"
  }
  spec {
    selector = {
      app = "popcorn-service"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_service" "defrost-service" {
  metadata {
    name = "defrost-service"
  }
  spec {
    selector = {
      app = "defrost-service"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

#################################################################
# The Service for the Frontend Load Balancer Ingress
resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend"

    labels = {
      app  = "virtual-microwave"
    }
  }

  spec {
    selector = {
      app  = "virtual-microwave"
    }

    type = "LoadBalancer"

    port {
      port = 80
    }
  }
}