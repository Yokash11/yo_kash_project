resource "grafana_folder" "alerts" {
  title = "Terraform Alerts"
}

resource "grafana_rule_group" "alerts" {
  name             = "Grafana Alerts"
  folder_uid       = grafana_folder.alerts.uid
  interval_seconds = 60

  rule {
    name      = "High CPU Usage"
    condition = "B"
    for       = "30s"

    labels = {
      severity = "warning"
      route    = "incident.io"
      my_catalog = "compute"
    }

    annotations = {
      description = "CPU usage is high"
      summary = "CPU usage is high"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    is_paused      = false

    data {
      ref_id = "A"

      relative_time_range {
        from = 300
        to   = 0
      }

      datasource_uid = data.grafana_data_source.prometheus.uid

      model = jsonencode({
        expr = "100 - (avg(rate(node_cpu_seconds_total{instance=\"grafana_server\", mode=\"idle\"}[5m])) * 100)"
        instant        = true
        range          = false
        intervalMs     = 1000
        maxDataPoints  = 43200
        refId          = "A"
      })
    }

    data {
      ref_id = "B"
      query_type = "expression"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"

      model = jsonencode({
        type       = "threshold"
        expression = "A"
        refId      = "B"

        conditions = [
          {
            type = "query"
            query = {
              params = ["A"]
            }
            reducer = {
              type   = "last"
              params = []
            }
            evaluator = {
              type   = "gt"
              params = [90]
            }
            operator = {
              type = "and"
            }
          }
        ]
      })
    }
  }

  rule {
    name      = "High Memory Usage"
    condition = "B"
    for       = "30s"

    labels = {
      severity = "critical"
      route    = "incident.io"
      my_catalog = "compute"
    }

    annotations = {
      description = "Memory usage is high"
      summary     = "Memory usage is high"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    is_paused      = false

    data {
      ref_id = "A"

      relative_time_range {
        from = 300
        to   = 0
      }

      datasource_uid = data.grafana_data_source.prometheus.uid
      
      model = jsonencode({
        expr = "(1 - (node_memory_MemAvailable_bytes{instance=\"grafana_server\"} / node_memory_MemTotal_bytes{instance=\"grafana_server\"})) * 100"
        instant        = true
        range          = false
        intervalMs     = 1000
        maxDataPoints  = 43200
        refId          = "A"
      })
    }

    data {
      ref_id    = "B"
      query_type = "expression"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"

      model = jsonencode({
        type       = "threshold"
        expression = "A"
        refId      = "B"

        conditions = [
          {
            type = "query"
            query = {
              params = ["A"]
            }
            reducer = {
              type   = "last"
              params = []
            }
            evaluator = {
              type   = "gt"
              params = [90]
            }
            operator = {
              type = "and"
            }
          }
        ]
      })
    }
  }

  rule {
    name      = "High Disk Usage"
    condition = "B"
    for       = "30s"

    labels = {
      severity = "critical"
      route    = "incident.io"
      my_catalog = "storage"
    }

    annotations = {
      description = "Disk usage is high"
      summary     = "Disk usage is high"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    is_paused      = false

    data {
      ref_id = "A"

      relative_time_range {
        from = 300
        to   = 0
      }

      datasource_uid = data.grafana_data_source.prometheus.uid

      model = jsonencode({
        expr = "100 * (1 - (node_filesystem_avail_bytes{instance=\"grafana_server\", mountpoint=\"/\", fstype!=\"tmpfs\"} / node_filesystem_size_bytes{instance=\"grafana_server\", mountpoint=\"/\", fstype!=\"tmpfs\"}))"
        instant        = true
        range          = false
        intervalMs     = 1000
        maxDataPoints  = 43200
        refId          = "A"
      })
    }

    data {
      ref_id = "B"
      query_type = "expression"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"

      model = jsonencode({
        type       = "threshold"
        expression = "A"
        refId      = "B"

        conditions = [
          {
            type = "query"
            query = {
              params = ["A"]
            }
            reducer = {
              type   = "last"
              params = []
            }
            evaluator = {
              type   = "gt"
              params = [90]
            }
            operator = {
              type = "and"
            }
          }
        ]
      })
    }
  }
}
