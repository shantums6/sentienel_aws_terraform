resource "aws_servicecatalog_provisioned_product" "prod_account" {
  name = "App-Prod-Account"

  # Using these IDs directly is the most reliable way to fix your error
  product_id               = "prod-3zjmn2kytkkuu"
  provisioning_artifact_id = "pa-7e2ehdqfozg54"

  provisioning_parameters {
    key   = "AccountEmail"
    value = "aws-prod060824@proton.me" # Ensure this is a unique email you haven't used yet
  }

  provisioning_parameters {
    key   = "AccountName"
    value = "App-Prod"
  }

  provisioning_parameters {
    key   = "ManagedOrganizationalUnit"
    value = "workloads (ou-d48b-hqhocsae)"
  }

  provisioning_parameters {
    key   = "SSOUserEmail"
    value = "shanthusvh@gmail.com"
  }

  provisioning_parameters {
    key   = "SSOUserFirstName"
    value = "shanthu"
  }

  provisioning_parameters {
    key   = "SSOUserLastName"
    value = "m"
  }
}
