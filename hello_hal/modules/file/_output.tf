output "file_content" {
  value = "${local_file.hello_world.content}"
}

output "file_name" {
  value = "${local_file.hello_world.filename}"
}
