resource "local_file" "application" {
  filename = var.filename
  content  = var.content
}
