resource "grafana_folder" "folder" {
  title = "Grafana_Server - incident.io Project"
  uid   = "Grafana-Server-incident_io-Project-uid"
}

resource "grafana_dashboard" "dashboard" {
  folder = grafana_folder.folder.uid
  config_json = file("${path.module}/dashboard.json")
  overwrite= true
}