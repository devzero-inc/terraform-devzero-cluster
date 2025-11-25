resource "helm_release" "devzero_operator" {
  name             = var.release_name
  chart            = var.chart_name
  repository       = var.chart_repository
  namespace        = var.namespace
  create_namespace = var.create_namespace
  atomic           = var.atomic
  wait             = var.wait
  version          = var.chart_version
  
  # Allow full customization of Helm values
  values = var.values_yaml != null ? [var.values_yaml] : null
  
  # Support individual value overrides
  dynamic "set" {
    for_each = concat(local.default_values, var.set_values)
    content {
      name  = set.value.name
      value = set.value.value
      type  = lookup(set.value, "type", null)
    }
  }
  
  # Support sensitive value overrides
  dynamic "set_sensitive" {
    for_each = concat(local.default_sensitive_values, var.set_sensitive_values)
    content {
      name  = set_sensitive.value.name
      value = set_sensitive.value.value
      type  = lookup(set_sensitive.value, "type", null)
    }
  }
}