variable "instances" {
  description = "instance_type"
  type        = map
  default     = {
    prode = {
      instance_type           = "free",
      name                    = "node_1"
    },
    stage = {
      instance_type           = "free",
      name                    = "node_2"
    }
  }
}
