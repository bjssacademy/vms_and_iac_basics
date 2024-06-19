# Define your Variables here
# See: https://www.terraform.io/docs/language/values/variables.html

variable "region" {
  description = "Deployment Region"
  type        = string
  default     = "uksouth"
}

variable "somevariable" {
  description = "Define String Variables like this"
  type        = string
}

