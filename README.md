# Hashicorp Consul Demo

* Following instructions at https://github.com/hashicorp/terraform-google-consul


## Gotchas

* Make sure `cluster_tag_name` is exactly the same as the `cluster-tag-name`
specified in the startup script
* If standing up cluster without external IPs, you need to enable Private Google
Access on the subnet, otherwise the Cloud Auto-Join won't work
