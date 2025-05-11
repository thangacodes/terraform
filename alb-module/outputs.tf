output "finding_pubip" {
  value = module.vm.vmpubip
}
output "finding_pvtip" {
  value = module.vm.vmpvtip
}

output "alb_dns_name" {
  value = module.app-alb.alb_dns_name
}

output "alb_arn" {
  value = module.app-alb.alb_arn
}

output "alb_zone_id" {
  value = module.app-alb.alb_zone_id
}

output "instance_id_map" {
  value = module.vm.instance_id_map
}

output "tg-arn" {
  value = module.app-alb.tg-arn
}