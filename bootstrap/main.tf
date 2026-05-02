resource "aws_servicecatalog_provisioned_product" "prod_account" {
  name                       = "App-Prod-Account"
  product_name               = "AWS Control Tower Account Factory"
  provisioning_artifact_name = "AWS Control Tower Account Factory"

  provisioning_parameters {
    key   = "AccountEmail"
    value = "aws-prod060824@proton.me" # Use a unique email
  }

  provisioning_parameters {
    key   = "AccountName"
    value = "App-Prod"
  }

  provisioning_parameters {
    key   = "ManagedOrganizationalUnit"
    value = "workloads (ou-d48b-hqhocsae)" # Ensure this matches your exact OU string
  }

  provisioning_parameters {
    key   = "SSOUserEmail"
    value = "shanthusvh@gmail.com"
  }

  provisioning_parameters {
    key   = "SSOUserFirstName"
    value = "shanthu" # Replace with your name
  }

  provisioning_parameters {
    key   = "SSOUserLastName"
    value = "m" # Replace with your name
  }
}
