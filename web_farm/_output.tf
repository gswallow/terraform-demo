output "vpc_id" {
  value = "${data.terraform_remote_state.vpc.vpc_id}"
}
