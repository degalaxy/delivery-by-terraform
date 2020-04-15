output "Tips" {
  value=" \n -------------------cloud-------------------- \n 
HWCLOUD_API_SECRET   SecretKey=${var.hw_secret_key};AccessKey=${var.hw_access_key};DomainId=xxxxxxxx \n 
HWCLOUD_LOCATION   CloudApiDomainName=myhuaweicloud.com;Region=${var.hw_region};ProjectId=xxxxxxxxx \n 
 \n 
-------------------vpc---------------------- \n 
${huaweicloud_vpc_v1.wecube_vpc.name}  ${huaweicloud_vpc_v1.wecube_vpc.id} \n 
 \n 
-------------------subnet------------------- \n 
${huaweicloud_vpc_subnet_v1.subnet_app.name}  ${huaweicloud_vpc_subnet_v1.subnet_app.id} \n 
${huaweicloud_vpc_subnet_v1.subnet_db.name}  ${huaweicloud_vpc_subnet_v1.subnet_db.id} \n 
${huaweicloud_vpc_subnet_v1.subnet_vdi.name}  ${huaweicloud_vpc_subnet_v1.subnet_vdi.id} \n 
${huaweicloud_vpc_subnet_v1.subnet_proxy.name}  ${huaweicloud_vpc_subnet_v1.subnet_proxy.id} \n 
 \n 
-------------------host---------------------- \n 
${huaweicloud_ecs_instance_v1.instance_wecube_platform.name} ${huaweicloud_ecs_instance_v1.instance_wecube_platform.id} \n 
${huaweicloud_ecs_instance_v1.instance_plugin_docker_host_a.name} ${huaweicloud_ecs_instance_v1.instance_plugin_docker_host_a.id} \n 
${huaweicloud_ecs_instance_v1.instance_squid.name} ${huaweicloud_ecs_instance_v1.instance_squid.id} \n 
${huaweicloud_ecs_instance_v1.instance_vdi.name} ${huaweicloud_ecs_instance_v1.instance_vdi.id} \n 
 \n 
-------------------mysqldb------------------ \n 
${huaweicloud_rds_instance_v3.mysql_instance_wecube_core.name} ${huaweicloud_rds_instance_v3.mysql_instance_wecube_core.id} \n 
${huaweicloud_rds_instance_v3.mysql_instance_plugin.name} ${huaweicloud_rds_instance_v3.mysql_instance_plugin.id} \n 
 \n 
-------------------mysqldb------------------ \n 
 \n 
 \n 
\n Please follow below steps:\n 1.Login your Windows VDI[IP:${huaweicloud_networking_floatingip_v2.vdi_public_ip.address}] with [User/Password：Administrator/${var.default_password}];\n 2.Install Chrome browser;\n 3.Use Chrome browser to access 'http://10.128.202.2:19090';\n \n \n Thank you in advance for your kind support and continued business.\n More Info: https://github.com/WeBankPartners/delivery-by-terraform"
}