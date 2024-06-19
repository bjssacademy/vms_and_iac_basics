variable "team_name" {
  type = string
  validation {
    condition     = can(regex("^[a-z]{1,12}", var.team_name))
    error_message = "Team name must be a lowercase alphabetical string less than 12chars."
  }
}

variable "user_id" {
  type = string
  validation {
    condition     = can(regex("^[a-z]{1,12}", var.user_id))
    error_message = "User must be a lowercase alphabetical string less than 12chars."
  }
}


