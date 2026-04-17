# 1. Create the VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

# 2. Create the Internet Gateway (The door to the internet)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# 3. Create Public Subnets (For Load Balancers)
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true # Automatically give resources a public IP

  tags = {
    Name                     = "${var.vpc_name}-public-${count.index + 1}"
    "kubernetes.io/role/elb" = "1" # Required for EKS to find public subnets
  }
}

# 4. Create Private Subnets (For EKS Worker Nodes & RDS)
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name                              = "${var.vpc_name}-private-${count.index + 1}"
    "kubernetes.io/role/internal-elb" = "1" # Required for EKS internal load balancers
  }
}

# Note: To keep your practice costs at zero, I intentionally left out the NAT Gateway 
# and Route Tables for the private subnets. We will route our practice EKS nodes 
# intelligently later!
