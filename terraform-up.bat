terraform fmt
terraform validate
terraform apply -auto-approve
terraform import azapi_resource.scm-policy "/subscriptions/baa4da18-4abd-4ed6-b3ed-1bffa64e4b6b/resourceGroups/myapp-rg/providers/Microsoft.Web/sites/myapp-jonguz-xyz-webapp/basicPublishingCredentialsPolicies/scm"
terraform import azapi_resource.ftp-policy "/subscriptions/baa4da18-4abd-4ed6-b3ed-1bffa64e4b6b/resourceGroups/myapp-rg/providers/Microsoft.Web/sites/myapp-jonguz-xyz-webapp/basicPublishingCredentialsPolicies/ftp"
terraform apply -auto-approve