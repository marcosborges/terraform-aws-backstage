# RDS AND EC2

module "backstage" {

  source = "../../"

  backstage_rds_enable = true
  backstage_rds = {
    identifier                            = "backstage"
    engine                                = "postgres"
    engine_version                        = "11.10"
    family                                = "postgres11" # DB parameter group
    major_engine_version                  = "11"         # DB option group
    instance_class                        = "db.t3.large"
    allocated_storage                     = 20
    max_allocated_storage                 = 100
    storage_encrypted                     = false
    name                                  = "completePostgresql"
    username                              = "complete_postgresql"
    password                              = "YourPwdShouldBeLongAndSecure!"
    port                                  = 5432
    multi_az                              = true
    subnet_ids                            = module.vpc.database_subnets
    vpc_security_group_ids                = [module.security_group.security_group_id]
    maintenance_window                    = "Mon:00:00-Mon:03:00"
    backup_window                         = "03:00-06:00"
    enabled_cloudwatch_logs_exports       = ["postgresql", "upgrade"]
    backup_retention_period               = 0
    skip_final_snapshot                   = true
    deletion_protection                   = false
    performance_insights_enabled          = true
    performance_insights_retention_period = 7
    create_monitoring_role                = true
    monitoring_interval                   = 60
    monitoring_role_name                  = "example-monitoring-role-name"
    monitoring_role_description           = "Description for monitoring role"
    parameters = [
      {
        name  = "autovacuum"
        value = 1
      },
      {
        name  = "client_encoding"
        value = "utf8"
      }
    ]
    db_option_group_tags = {
      "Sensitive" = "low"
    }
    db_parameter_group_tags = {
      "Sensitive" = "low"
    }
    db_subnet_group_tags = {
      "Sensitive" = "high"
    }
  }

  backstage_ec2_enable = true
  backstage_ec2 = {

  }


  backstage_techdoc_s3_enable = true
  backstage_techdoc_s3 = {

  }

  backstage_helm_enable = true
  backstage_helm = {

  }

  subnet_id = data.aws_subnet.current.id




}
