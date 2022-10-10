terraform {
  source = "git::git@github.com:hsnrathore/infrastructure-modules.git//ecs?ref=v2.0"
}
# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/ecs.hcl"
}

# ---------------------------------------------------------------------------------------------------------------------
# Override parameters for this environment
# ---------------------------------------------------------------------------------------------------------------------

# For production, we want to specify bigger instance classes and cluster, so we specify override parameters here. These
# inputs get merged with the common inputs from the root and the envcommon terragrunt.hcl
inputs = {
  app_name      = "plana"
  task_cpu      = 512
  task_memory   = 1024
  desired_count = 2
}




