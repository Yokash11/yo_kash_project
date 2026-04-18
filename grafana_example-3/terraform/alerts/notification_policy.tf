resource "grafana_notification_policy" "root" {
  group_by = ["..."]
  contact_point = "empty"

  policy {
    matcher {
      label = "route"
      match = "="
      value = "incident.io"
    }
    group_by = [ "..." ]
    contact_point = grafana_contact_point.incident_io.name
  }

  policy {
    matcher {
      label = "route"
      match = "="
      value = "default-email"
    }
    group_by = [ "..." ]
    contact_point = "grafana-default-email"
  }

  policy {
    matcher {
      label = "route"
      match = "="
      value = "pagerduty"
    }
    group_by = [ "..." ]
    contact_point = "yo_kash_project_pd_alert_notifications"
  }
}