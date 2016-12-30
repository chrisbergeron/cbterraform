# cbterraform
Terraform configuration and deployment

Environment variables to set

This value will be set to the providers
export SSH_FINGERPRINT=85:02:0a:2e:05:a........79:90:27:dc:a8:bc:a8:e0

This is the API key that the provider (DO) gave us.  This can be generated via the Droplet Control Panel.
export DO_PAT=c653ab423............92cab324

Deploying via terraform

View execution plan:
terraform plan -var "do_token=${DO_PAT}" -var "pub_key=$HOME/.ssh/id_rsa.pub" -var "pvt_key=$HOME/.ssh/id_rsa_decrypted" -var "ssh_fingerprint=$SSH_FINGERPRINT"

Actual deployment via terraform:
terraform apply -var "do_token=${DO_PAT}" -var "pub_key=$HOME/.ssh/id_rsa.pub" -var "pvt_key=$HOME/.ssh/id_rsa_decrypted" -var "ssh_fingerprint=$SSH_FINGERPRINT"

-----------------------------

Destroying infrastructure via terraform

Generate the execution plan
1) terraform plan -destroy -out=terraform.tfplan \
  -var "do_token=${DO_PAT}" \
  -var "pub_key=$HOME/.ssh/id_rsa.pub" \
  -var "pvt_key=$HOME/.ssh/id_rsa" \
  -var "ssh_fingerprint=$SSH_FINGERPRINT"

2) terraform apply terraform.tfplan

or

terraform destroy -var "do_token=${DO_PAT}" -var "pub_key=$HOME/.ssh/id_rsa.pub" -var "pvt_key=$HOME/.ssh/id_rsa_decrypted" -var "ssh_fingerprint=$SSH_FINGERPRINT"

-----------------------------

Generating SSH_FINGERPRINT on OS X El Capitan:
ssh-keygen -E md5 -lf ~/.ssh/id_rsa

Decrypting an encrypted SSH key:
openssl rsa -in ~/.ssh/id_rsa -out ~/.ssh/id_rsa_decrypted
