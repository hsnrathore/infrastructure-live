# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for webserver-cluster. The common variables for each environment to
# deploy webserver-cluster are defined here. This configuration will be merged into the environment configuration
# via an include block.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment

  # Expose the base source URL so different versions of the module can be deployed in different environments.
  base_source_url = "git::git@github.com:hsnrathore/infrastructure-modules.git//ecs"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "iam" {
  config_path = "../iam"
}

dependency "alb" {
  config_path = "../alb"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module. This defines the parameters that are common across all
# environments.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  cluster_name             = "ecscluster-${local.env}"
  environment              = "${local.env}"
  container_image          = "nginx"
  container_port           = "80"
  vpc_id                   = dependency.vpc.outputs.vpc_id
  ecs_task_role            = dependency.iam.outputs.task_role_arn
  subnets                  = dependency.vpc.outputs.aws_private_subnets
  ecs_task_execution_role  = dependency.iam.outputs.task_execution_role_arn
  aws_alb_target_group_arn = dependency.alb.outputs.target_group_arn
}
