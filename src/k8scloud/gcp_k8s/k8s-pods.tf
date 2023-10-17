variable "docker-server" {
    type = string
}

variable "gitlab-token" {
    type = string
}

#####################################################################
# Create secret for docker registry
#####################################################################
resource "kubernetes_secret" "docker-registry" {
  metadata {
    name = "docker-registry"
  }

  data = {
    ".dockerconfigjson" = "${data.template_file.docker_config_script.rendered}"
  }

  type = "kubernetes.io/dockerconfigjson"
}

data "template_file" "docker_config_script" {
  template = "${file("${path.module}/../dockerconfig.json")}"
  vars = {
    registry-server             = "${var.registry-server}"
    auth                      = base64encode("${var.registry-username}:${var.registry-token}")
  }
}

#################################################################
# Definition of the Pods
#################################################################

resource "kubernetes_deployment" "potato-service" {
  metadata {
    name = "potato-service"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app  = "potato-service"
      }
    }
    template {
      metadata {
        labels = {
          app  = "potato-service"
        }
      }
      spec {
        image_pull_secrets {
          name = "docker-registry"
        }

        container {
          image = "registry.rnl.tecnico.ulisboa.pt/agisit/agisit23-g26/potato-service:latest"
          name  = "potato-service"

          port {
            container_port = 80
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "beverage-service" {
  metadata {
    name = "beverage-service"
  }

  spec {
    progress_deadline_seconds = 1200 # In case of taking longer than 9 minutes
    replicas = 2
    selector {
      match_labels = {
        app  = "beverage-service"
      }
    }
    template {
      metadata {
        labels = {
          app  = "beverage-service"
        }
      }
      spec {
        image_pull_secrets {
          name = "docker-registry"
        }

        container {
          image = "registry.rnl.tecnico.ulisboa.pt/agisit/agisit23-g26/beverage-service:latest"
          name  = "beverage-service"

          port {
            container_port = 80
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "popcorn-service" {
  metadata {
    name = "popcorn-service"
  }

  spec {
    progress_deadline_seconds = 1200 # In case of taking longer than 9 minutes
    replicas = 2
    selector {
      match_labels = {
        app  = "popcorn-service"
      }
    }
    template {
      metadata {
        labels = {
          app  = "popcorn-service"
        }
      }
      spec {
        image_pull_secrets {
          name = "docker-registry"
        }

        container {
          image = "registry.rnl.tecnico.ulisboa.pt/agisit/agisit23-g26/popcorn-service:latest"
          name  = "popcorn-service"

          port {
            container_port = 80
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "defrost-service" {
  metadata {
    name = "defrost-service"
  }

  spec {
    progress_deadline_seconds = 1200 # In case of taking longer than 9 minutes
    replicas = 2
    selector {
      match_labels = {
        app  = "defrost-service"
      }
    }
    template {
      metadata {
        labels = {
          app  = "defrost-service"
        }
      }
      spec {
        image_pull_secrets {
          name = "docker-registry"
        }

        container {
          image = "registry.rnl.tecnico.ulisboa.pt/agisit/agisit23-g26/defrost-service:latest"
          name  = "defrost-service"

          port {
            container_port = 80
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}

#################################################################
# Defined the Frontend Pods
resource "kubernetes_deployment" "virtual-microwave" {
  metadata {
    name = "virtual-microwave"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app  = "virtual-microwave"
      }
    }

    template {
      metadata {
        labels = {
          app  = "virtual-microwave"
        }
      }
      spec {
        image_pull_secrets {
          name = "docker-registry"
        }

        container {
          image = "registry.rnl.tecnico.ulisboa.pt/agisit/agisit23-g26/frontend:latest"
          name  = "virtual-microwave"

          port {
            container_port = 80
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}
