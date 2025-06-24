terraform {
  backend "remote" {
    organization = "Venom319"

    workspaces {
      name = "diplom-terraform"
    }
  }
}