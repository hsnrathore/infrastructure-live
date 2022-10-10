To run this terragrunt simply make use of the following commands:

terragrunt init
terragrunt plan
terragrunt apply


Please make sure to configue aws cli on your system with a test account profile and update the profile variable in the main terragrunt.hcl file. Module repo has already been published to github so this live repo will call the modules using the module repo.