provider "boundary" {
  addr             = "https://boundary.home.lan"
  recovery_kms_hcl = <<EOT
kms "aead" {
    purpose   = "recovery"
    aead_type = "aes-gcm"
    key       = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
    key_id    = "global_recovery"
}
EOT
}

