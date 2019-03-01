locals {
  my_file = "${path.root}/hello-${var.my_name}.txt"
}

resource "local_file" "hello_world" {
  content  = "${var.my_name}\n"
  filename = "${local.my_file}"
}
