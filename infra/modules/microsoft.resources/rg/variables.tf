variable "rgName" {
  type        = string
  description = "The name of the resource group"
}

variable "rgLocation" {
  type        = string
  description = "The location of the resource group"
}

variable "rgTags" {
  type        = map(string)
  description = "A map of tags to apply to the resource group"
  default     = {}
}
