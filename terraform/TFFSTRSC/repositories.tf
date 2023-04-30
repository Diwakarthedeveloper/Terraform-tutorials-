

resource "github_repository" "terrafor-first-repo" { # name on your locl machine
  name        = "first-repo-from-repository" #name on github
  description = "Github by Terraform" #description on github

  visibility = "public"
  auto_init = true # to create a readme file   
}


