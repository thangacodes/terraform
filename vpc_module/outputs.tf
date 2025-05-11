output "vpc_id" {
  value = module.vpc.vpc_id
}

output "igw_id" {
  value = module.vpc.igw_id
}

output "pub_subnet_ids" {
  value = module.vpc.pub_subnet_ids
}

output "pvt_subnet_ids" {
  value = module.vpc.pvt_subnet_ids

}

output "pub_subnet_cidrs" {
  value = module.vpc.pub_subnet_cidrs
}

output "pvt_subnet_cidrs" {
  value = module.vpc.pvt_subnet_cidrs
}

output "availability_zone_ids" {
  value = module.vpc.availability_zone_ids
}
