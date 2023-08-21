terraform state rm azapi_resource.ftp-policy
terraform state rm azapi_resource.scm-policy
terraform state list
terraform destroy -auto-approve