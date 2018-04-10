module "db" {
  source                  = "../modules/rds"
  env                     = "${var.env}"
  db_name                 = "${var.env}_${var.appname}"
  db_identifier           = "${var.env}-${var.appname}-rds"
  db_sg_name              = "${var.env}_${var.appname}_db_sg"
  db_engine               = "mysql"
  db_engine_version       = "5.7.21"
  db_instance_class       = "${var.db_instance_class}"
  db_username             = "root"
  db_password             = "${var.db_password}"
  db_subnet_group_id      = "${var.env}_db_subnet_group"
  backup_retention_period = "${var.backup_retention_period}"
  multi_az                = "${var.multi_az}"
  backup_window           = "${var.backup_window}"
  maintenance_window      = "${var.maintenance_window}"
  allocated_storage       = "${var.allocated_storage}"
  storage_type            = "${var.storage_type}"
  apply_immediately       = "${var.apply_immediately}"
}

module "security-groups" {
  source                  = "../modules/security-groups"
  env                     = "${var.env}"
  app_security_group_name = "${var.env}_${var.appname}_app_sg"
  db_security_group_id    = "${module.db.db_security_group_id}"
  db_port                 = "3306"
}
