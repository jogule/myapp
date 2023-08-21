terraform destroy -auto-approve

gh secret list -R https://github.com/jogule/myapp
#NAME                                                             UPDATED
#AZUREAPPSERVICE_PUBLISHPROFILE_7A6B0624D79D4B2C88736B26996DA62B  about 5 minutes ago
#AZUREAPPSERVICE_PUBLISHPROFILE_B623798C987E471B99DB06D76B0E9382  about 4 minutes ago
#AZUREAPPSERVICE_PUBLISHPROFILE_C87FCA4385394C2B84D8EE8A51FCDCAD  about 3 minutes ago
#gh secret delete AZUREAPPSERVICE_PUBLISHPROFILE_7A6B0624D79D4B2C88736B26996DA62B -R https://github.com/jogule/myapp
#gh secret delete AZUREAPPSERVICE_PUBLISHPROFILE_B623798C987E471B99DB06D76B0E9382 -R https://github.com/jogule/myapp
#gh secret delete AZUREAPPSERVICE_PUBLISHPROFILE_C87FCA4385394C2B84D8EE8A51FCDCAD -R https://github.com/jogule/myapp

rm -rf .github/workflows
git add .
git commit -m "delete workflows"
git pull origin main
git push origin HEAD
