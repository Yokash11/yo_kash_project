resource "grafana_contact_point" "incident_io" {
    name                                = "Grafana Alerts (incident.io)"
    webhook {
        url                             = "your_url_here"
        authorization_credentials       = "your_token_here"           
    }
}