disable_mlock = true
log_format    = "standard"
controller {
  name        = "kubernetes-controller"
  description = "A controller for a kubernetes demo!"
  database {
    url = "file:///vault/secrets/database-creds.txt"
  }
  public_cluster_addr = "localhost"
}
worker {
  name        = "kubernetes-worker"
  description = "A worker for a kubernetes demo"
  address     = "localhost"
  controllers = ["localhost"]
  public_addr = "192.168.1.101:30202"
}
listener "tcp" {
  address     = "0.0.0.0"
  purpose     = "api"
  tls_disable = true
}
listener "tcp" {
  address     = "0.0.0.0"
  purpose     = "cluster"
  tls_disable = true
}
listener "tcp" {
  address     = "0.0.0.0"
  purpose     = "proxy"
  tls_disable = true
}
kms "transit" {
  purpose         = "root"
  address         = "{{ .Values.vault.fqdn }}"
  disable_renewal = false

  key_name   = "root"
  mount_path = "local-kms/"

  tls_skip_verify = true
}
kms "transit" {
  purpose         = "recovery"
  address         = "{{ .Values.vault.fqdn }}"
  disable_renewal = false

  key_name   = "recovery"
  mount_path = "local-kms/"

  tls_skip_verify = true
}
kms "transit" {
  purpose         = "worker-auth"
  address         = "{{ .Values.vault.fqdn }}"
  disable_renewal = false

  key_name   = "worker-auth"
  mount_path = "local-kms/"

  tls_skip_verify = true
}

