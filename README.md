# boundary-chart
Helm chart for Hashicorp Boundary

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/boundary-chart)](https://artifacthub.io/packages/search?repo=boundary-chart)

## Disclaimer
This is a work in progress. Currently, this allows three main configurations of Boundary, based on the KMS key configuration.

1. AEAD (Dev Mode, static keys)
2. Vault (requires connection to / installation of HashiCorp Vault)
3. Google Cloud KMS
4. Azure Key Vault

Obviously AWS, and OCI are also configurable KMS sources. These haven't been implemented in this chart yet.

## Requirements
This requires at minimum:
- A Kubernetes cluster
- A PostgreSQL database (can be external or cluster-internal)

Per HashiCorp's documentation, AEAD key sources should not be considered production-ready. Additional requirements for non-AEAD key sources (at this time):
- A Vault installation
- A Vault token that is periodic, renewable, orphan, and associated with a policy that allows Boundary to manage its keys.

## Usage
Currently, documentation is still underway, but the `values.yaml` file should give a decent idea of what to use. Per the `.gitignore` file, you can safely test locally by copying and modifying this file as `local-values.yaml`.

This is created as a passion project as there isn't a canonical Helm chart from HashiCorp as of yet; the creator(s) give no guarantees, and invite interested parties to contribute, adapt, and fork in accordance with the license.

## Tips
In lieu of full documentation, some tips:
- I (Jacob) have primarily used Terraform to manage configuration state for Scopes, Auth Methods, Hosts, Targets, etc. I would strongly recommend this if you are testing your setup.
- If you tweak the configuration of your Boundary installation significantly during development and try to re-install, especially with Vault, you may encounter strange Vault errors. At this time, the easiest way to deal with this is to terminate any backends in Postgres connected to the database, drop the database, and recreate it. **Do not do this on a production instance or if you do not have your configuration sufficiently recorded in Terraform.**
- At this time, the AEAD configuration will save your KMS root, recovery, and worker-auth keys in a ConfigMap, which should not be considered secure. I may eventually change this to create a Secret file, but this should still not be considered production-ready.
- I will create (and in short order) link a repository with some example Terraform files that can be used to create a functioning setup. It originally lived in this repo, but is way too specific for a generic Helm chart; still, it might be helpful for seeing an approach for setting up Boundary. It's also completely as-is, and relevant more to my own installation.

## My Dev Setup
This is not relevant to all, but will hopefully let you know the dev environment and limits I have for testing at this time:
- A Raspberry Pi 4 Four-Node cluster (using custom ARM64-compatible Docker image)
- Rancher K3s with distributed ETCD backend
- Nginx Ingress Controller
- External DNS using RFC-2136 against a Synology RT2600AC router
- Consul running in-cluster on all K8s nodes (used as Vault backend)
- Vault running in-cluster

I use AWS KMS at work, but haven't yet implemented any cloud-backed version of KMS for this chart. It should be easy to implement, but any of that work will be best-effort.

## Contributing
I am still working on some good Github Actions for this repo, but you are encouraged to pull and/or fork the code and make a PR. I'm just one person, so please give some grace. Sharing code is dope, and I hope this improves your life and/or work as well!
