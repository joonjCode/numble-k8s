terraform{
  required_providers {
    ncloud = {
      source = "NaverCloudPlatform/ncloud"
    }
  }
  required_version = ">=0.13"
}

provider "ncloud" {
  support_vpc = true
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "ncloud_vpc" "vpc"{
  ipv4_cidr_block = "192.168.0.0/20"
}

resource "ncloud_subnet" "private_sb_1"{
  vpc_no = ncloud_vpc.vpc.id
  subnet = "192.168.0.0/24"
  zone = "KR-1"
  name = "private-sb-1"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type = "PRIVATE"
  usage_type = "GEN"
}

# Load balancer subnet for KR1
resource "ncloud_subnet" "private_sb_lb"{
  vpc_no = ncloud_vpc.vpc.id
  subnet = "192.168.1.0/24"
  zone = "KR-1"
  name = "private-sb-lb"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type = "PRIVATE"
  usage_type = "LOADB"
}

resource "ncloud_subnet" "public_sb_1"{
  vpc_no = ncloud_vpc.vpc.id
  subnet = "192.168.2.0/24"
  zone = "KR-1"
  name = "public-sb-1"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type = "PUBLIC"
  usage_type = "GEN"
}


resource "ncloud_subnet" "public_sb_2"{
  vpc_no = ncloud_vpc.vpc.id
  subnet = "192.168.3.0/24"
  zone = "KR-2"
  name = "public-sb-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type = "PUBLIC"
  usage_type = "GEN"
}

# NAT Gateway for outbounds in NKS
resource "ncloud_nat_gateway" "nat_gateway"{
  vpc_no = ncloud_vpc.vpc.id
  zone = "KR-1"
  name = "nat-gw"
  description = "NAT GW for NKS outbounds"
}