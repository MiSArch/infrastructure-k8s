# How to add a new service

All services can be produced by copy-pasting the following things in the respective file and then replacing `$PREVIOUS_SERVICE` with `$NEW_SERVICE` and `$previous_service` with `$new_service` respectively.
Files containing the same thing for multiple services are expected to be alphabetically sorted.
When you add a new service, you need to copy and adapt the following things:
1. the deployment in `misarch-$new_service.tf`
1. a version variable in `variables-versions.tf`
1. a ConfigMap in `configmaps.tf`
1. an entry in `latest-deployments.tfvars`
1. a DB in `dbs.tf` if necessary
1. a password and output in `passwords.tf` if necessary
1. service specific annotations in `variables-annotations`
1. service specific labels in `variables-annotations`
1. service specific URLs in `variables-urls`

