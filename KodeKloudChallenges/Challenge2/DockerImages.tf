resource "docker_image" "php-httpd-image" {
    name = "php-httpd:challenge"
    build {
      dockerfile = "Dockerfile"
      path = "/root/code/terraform-challenges/challenge2/lamp_stack/php_httpd"
      tag = ["php-httpd:challenge"]
      build_arg = {
        context : "lamp_stack/php_httpd"
      }
      label = {
        challenge = "second"
      }
    }
}

resource "docker_image" "mariadb-image" {
    name = "mariadb:challenge"
    build {
      dockerfile = "Dockerfile"
      path = "/root/code/terraform-challenges/challenge2/lamp_stack/custom_db"
      tag = ["mariadb:challenge"]
      build_arg = {
        context : "lamp_stack/custom_db"
      }
      label = {
        challenge = "second"
      }
    }
}
