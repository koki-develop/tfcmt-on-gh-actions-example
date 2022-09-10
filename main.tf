data "docker_registry_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_image" "nginx" {
  name          = "nginx:latest"
  pull_triggers = [data.docker_registry_image.nginx.sha256_digest]
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx"

  ports {
    internal = 80
    external = 3000
  }
}
