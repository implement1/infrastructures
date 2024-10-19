# https://aws.amazon.com/blogs/apn/key-metrics-for-amazon-aurora/

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_disk_queue_depth_writer" {
  alarm_name = "${local.name_prefix}-disk-queue-depth-writer"

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "SampleCount"
  threshold           = 5

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "WRITER"
  }

  treat_missing_data = "ignore"

  alarm_actions = [
    var.sns_topic_non_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_non_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-disk-queue-depth-writer"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_disk_queue_depth_reader" {
  count = var.aurora_instance_count >= 2 ? 1 : 0

  alarm_name = "${local.name_prefix}-disk-queue-depth-reader"

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "SampleCount"
  threshold           = 5

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "READER"
  }

  treat_missing_data = "ignore"

  alarm_actions = [
    var.sns_topic_non_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_non_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-disk-queue-depth-reader"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_freeable_memory_writer_non_critical" {
  alarm_name = "${local.name_prefix}-freeable-mem-writer-non-crit"

  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.freeable_memory_threshold_non_critical

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "WRITER"
  }

  treat_missing_data = "breaching"

  alarm_actions = [
    var.sns_topic_non_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_non_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-freeable-mem-writer-non-crit"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_freeable_memory_writer_critical" {
  alarm_name = "${local.name_prefix}-freeable-mem-writer-crit"

  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.freeable_memory_threshold_critical

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "WRITER"
  }

  treat_missing_data = "breaching"

  alarm_actions = [
    var.sns_topic_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-freeable-mem-writer-crit"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_freeable_memory_reader_non_critical" {
  count = var.aurora_instance_count >= 2 ? 1 : 0

  alarm_name = "${local.name_prefix}-freeable-mem-reader-non-crit"

  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.freeable_memory_threshold_non_critical

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "READER"
  }

  treat_missing_data = "breaching"

  alarm_actions = [
    var.sns_topic_non_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_non_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-freeable-mem-reader-non-crit"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_freeable_memory_reader_critical" {
  count = var.aurora_instance_count >= 2 ? 1 : 0

  alarm_name = "${local.name_prefix}-freeable-mem-reader-crit"

  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.freeable_memory_threshold_critical

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "READER"
  }

  treat_missing_data = "breaching"

  alarm_actions = [
    var.sns_topic_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-freeable-mem-reader-crit"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_cpu_utilization_writer_non_critical" {
  alarm_name = "${local.name_prefix}-cpu-utilization-writer-non-crit"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_utilization_threshold_non_critical

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "WRITER"
  }

  treat_missing_data = "breaching"

  alarm_actions = [
    var.sns_topic_non_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_non_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-cpu-utilization-writer-non-crit"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_cpu_utilization_writer_critical" {
  alarm_name = "${local.name_prefix}-cpu-utilization-writer-crit"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_utilization_threshold_critical

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "WRITER"
  }

  treat_missing_data = "breaching"

  alarm_actions = [
    var.sns_topic_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-cpu-utilization-writer-crit"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_cpu_utilization_reader_non_critical" {
  count = var.aurora_instance_count >= 2 ? 1 : 0

  alarm_name = "${local.name_prefix}-cpu-utilization-reader-non-crit"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_utilization_threshold_non_critical

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "READER"
  }

  treat_missing_data = "breaching"
  alarm_actions = [
    var.sns_topic_non_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_non_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-cpu-utilization-reader-non-crit"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_cpu_utilization_reader_critical" {
  count = var.aurora_instance_count >= 2 ? 1 : 0

  alarm_name = "${local.name_prefix}-cpu-utilization-reader-crit"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_utilization_threshold_critical

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "READER"
  }

  treat_missing_data = "breaching"
  alarm_actions = [
    var.sns_topic_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-cpu-utilization-reader-crit"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_login_failures_writer_non_critical" {
  alarm_name          = "${local.name_prefix}-login-failures-writer-non-critical"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "LoginFailures"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = 5

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "WRITER"
  }

  alarm_actions = [
    var.sns_topic_non_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_non_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-login-failures-writer-non-critical"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_login_failures_writer_critical" {
  alarm_name          = "${local.name_prefix}-login-failures-writer-critical"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "LoginFailures"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = 20

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "WRITER"
  }

  alarm_actions = [
    var.sns_topic_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-login-failures-writer-critical"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_login_failures_reader_non_critical" {
  count = var.aurora_instance_count >= 2 ? 1 : 0

  alarm_name          = "${local.name_prefix}-login-failures-reader-non-critical"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "LoginFailures"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = 5

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "READER"
  }

  alarm_actions = [
    var.sns_topic_non_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_non_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-login-failures-reader-non-critical"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_login_failures_reader_critical" {
  count = var.aurora_instance_count >= 2 ? 1 : 0

  alarm_name          = "${local.name_prefix}-login-failures-reader-critical"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "LoginFailures"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = 5

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "READER"
  }

  alarm_actions = [
    var.sns_topic_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-login-failures-reader-critical"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_aborted_connects_writer" {
  alarm_name          = "${local.name_prefix}-aborted-connects-writer"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Aborted_connects"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = 1

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "WRITER"
  }

  alarm_actions = [
    var.sns_topic_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-aborted-connects-writer"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_aborted_connects_reader" {
  count = var.aurora_instance_count >= 2 ? 1 : 0

  alarm_name          = "${local.name_prefix}-aborted-connects-reader"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Aborted_connects"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = 1

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "READER"
  }

  alarm_actions = [
    var.sns_topic_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-aborted-connects-reader"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_connect_errors_max_connections_writer" {
  alarm_name          = "${local.name_prefix}-connection-errors-max-connections-writer"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Connection_errors_max_connections"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = 1

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "WRITER"
  }

  alarm_actions = [
    var.sns_topic_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-connection-errors-max-connections-writer"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "aurora_cluster_connect_errors_max_connections_reader" {
  count = var.aurora_instance_count >= 2 ? 1 : 0

  alarm_name          = "${local.name_prefix}-connection-errors-max-connections-reader"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Connection_errors_max_connections"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = 1

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.default.id
    Role                = "READER"
  }

  alarm_actions = [
    var.sns_topic_critical_arn,
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-connection-errors-max-connections-reader"
    Owner       = var.owner
  }

  provider = aws.default
}
