
# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/vpc.hcl"
}
terraform {
  source = "git::git@github.com:hsnrathore/infrastructure-modules.git//vpc?ref=v2.0"
}

# ---------------------------------------------------------------------------------------------------------------------
# Override parameters for this environment
# ---------------------------------------------------------------------------------------------------------------------

# For production, we want to specify bigger instance classes and cluster, so we specify override parameters here. These
# inputs get merged with the common inputs from the root and the envcommon terragrunt.hcl
inputs = {
  cidr_block = "10.0.0.0/16"

  private_subnets    = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  public_subnets     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
}