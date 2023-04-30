provider "github" { #to tell terraform which provider to use , here github
    token = "gWILL NOT WORK6rc"  #this token will given access tou your github account

}


resource "github_repository" "terrafor-first-repo" { # name on your locl machine
  name        = "first-repo-from-repository" #name on github
  description = "Github by Terraform" #description on github

  visibility = "public"
  auto_init = true # to create a readme file   
}

#if we want to delete a resource give -> terraform destroy --target resource_name.name_of_resource_on_local_machine
resource "github_repository" "terrafor-Second-repo" { # second name on your local machine
  name        = "Second-repo-from-repository" # second repo name on github
  description = "Github by Terraform second repo" #description on github

  visibility = "public"
  auto_init = true # to create a readme file 

}