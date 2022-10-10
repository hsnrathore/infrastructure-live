terraform {
  source = "git::git@github.com:hsnrathore/infrastructure-modules.git//alb?ref=v2.0"
}
include "root" {
  path = find_in_parent_folders()
}
include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/alb.hcl"
}

inputs = {
  app_name = "plana"
}
