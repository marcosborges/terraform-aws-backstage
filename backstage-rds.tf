################################################################################
# RDS Module
################################################################################

module "backstage_rds" {

  for_each = var.backstage_rds_enable ? [var.backstage_rds] : {}

  source  = "terraform-aws-modules/rds/aws"
  version = "3.5.0"

  identifier                            = each.value.options.identifier
  engine                                = each.value.options.engine
  engine_version                        = each.value.options.engine_version
  family                                = each.value.options.family
  major_engine_version                  = each.value.options.major_engine_version
  instance_class                        = each.value.options.instance_class
  allocated_storage                     = each.value.options.allocated_storage
  max_allocated_storage                 = each.value.options.max_allocated_storage
  storage_encrypted                     = each.value.options.storage_encrypted
  name                                  = each.value.options.name
  username                              = each.value.options.username
  password                              = each.value.options.password
  port                                  = each.value.options.port
  multi_az                              = each.value.options.multi_az
  subnet_ids                            = each.value.options.subnet_ids
  vpc_security_group_ids                = each.value.options.vpc_security_group_ids
  maintenance_window                    = each.value.options.maintenance_window
  backup_window                         = each.value.options.backup_window
  enabled_cloudwatch_logs_exports       = each.value.options.enabled_cloudwatch_logs_exports
  backup_retention_period               = each.value.options.backup_retention_period
  skip_final_snapshot                   = each.value.options.skip_final_snapshot
  deletion_protection                   = each.value.options.deletion_protection
  performance_insights_enabled          = each.value.options.performance_insights_enabled
  performance_insights_retention_period = each.value.options.performance_insights_retention_period
  create_monitoring_role                = each.value.options.create_monitoring_role
  monitoring_interval                   = each.value.options.monitoring_interval
  monitoring_role_name                  = each.value.options.monitoring_role_name
  monitoring_role_description           = each.value.options.monitoring_role_description
  parameters                            = each.value.options.parameters
  tags                                  = concat(local.tags, each.value.options.tags)
  db_option_group_tags                  = each.value.options.db_option_group_tags
  db_parameter_group_tags               = each.value.options.db_parameter_group_tags
  db_subnet_group_tags                  = each.value.options.db_subnet_group_tags
}
