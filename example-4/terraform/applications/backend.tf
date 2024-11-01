terraform {
  backend "remote" {
    organization = "yo_kash_project"

    workspaces {
        prefix = "yo_kash_project_"
    }
  }
}