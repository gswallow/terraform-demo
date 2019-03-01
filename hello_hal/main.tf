module "hello_world" {
  my_name = "${var.my_name}"
  source  = "./modules/file"
}

#module "hello_greg" {
#  my_name = "Greg"
#  source = "./modules/file"
#}

