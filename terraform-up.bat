terraform fmt
terraform validate
terraform apply -auto-approve

git mv "main_myapp-jonguz-xyz-webapp.yml" PRD.yml
git mv "main_myapp-jonguz-xyz-webapp(qa).yml" QAS.yml
git mv "main_myapp-jonguz-xyz-webapp(staging).yml" STG.yml

gh workflow list -R https://github.com/jogule/myapp -a
#Azure App Service - myapp-jonguz-xyz-webapp(qa), Build and deploy DotnetCore app          active             66903386
#Azure App Service - myapp-jonguz-xyz-webapp(staging), Build and deploy DotnetCore app     active             66886016
#Azure App Service - myapp-jonguz-xyz-webapp(Production), Build and deploy DotnetCore app  disabled_manually  66800094

#edit PRD.yml
#name: PRD
gh workflow disable "myapp-jonguz-xyz-webapp(Production)" -R https://github.com/jogule/myapp

#edit STG.yml
#name: STG

#edit QAS.yml
#name: QAS
#on:
# push:
#   branches:
#     - feat/*

git add .
git commit -m "setup workflows"
git pull origin main
git push origin HEAD
