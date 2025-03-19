# Variables
variable "pets_count" {
  description = "Number of random pets to generate"
  type        = number
  default     = 3
}

variable "pet_words" {
  description = "Number of words in each pet name"
  type        = number
  default     = 2
}

variable "string_length" {
  description = "Length of the random string"
  type        = number
  default     = 16
}

# Generate random pet names
resource "random_pet" "ourhoard" {
  count  = var.pets_count
  length = var.pet_words
  keepers = {
    # Generate a new pet name each time the time changes
    make_on_every_apply = timestamp()
  }
}

# Generate random strings
resource "random_string" "random" {
  count            = var.pets_count
  length           = var.string_length
  special          = true
  override_special = "/@£$"
  keepers = {
    # Generate a new string each time the time changes
    make_on_every_apply = timestamp()
  }
}

# Outputs
output "pet_names" {
  description = "Generated pet names"
  value       = random_pet.ourhoard[*].id
}

output "random_strings" {
  description = "Generated random strings"
  value       = random_string.random[*].result
}

output "combined_results" {
  description = "Combined pet names and random strings"
  value = {
    for i in range(var.pets_count) : random_pet.ourhoard[i].id => random_string.random[i].result
  }
} 