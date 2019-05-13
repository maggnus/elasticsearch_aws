# Elasticsearch deployment in AWS cloud

## Deployment overview

This deployment include provisioning AWS instances with Terraform and cluster setup with Ansible playbook.



## Prerequisites

You have to be installed:

1. Ansible (`pip install ansible`)

2. Terraform (<https://www.terraform.io/downloads.html>)



## Provisioning AWS instances

For security reason terraform read AWS credentials from the environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

To provision instance run commands inside terraform subfolder:

```
cd terraform
terraform apply
```

It should create new instances, for example:

```
Outputs:

es_node.ips = [
    18.138.224.233,
    13.229.139.191,
    18.138.225.226
]
```



Global defined variables (vars.tf):

| Parameter       | Description                                 | Example               |
| --------------- | ------------------------------------------- | --------------------- |
| region          | AWS region                                  | ap-southeast-1        |
| vpc_cidr        | VPC network in CIDR notation                | 10.8.0.0/16           |
| vpc_subnet_cidr | VPC subnet in CIDR notation                 | 10.8.1.0/24           |
| cluster_size    | Number of instance in Elasticsearch cluster | 3                     |
| ami_id          | AMI id for the specific `region`            | ami-0b419c3a4b01d1859 |
| ami_type        | Instance type                               | t2.micro              |



## Deploy Elasticsearch cluster

To deploy Elasticsearch cluster run commands inside ansible subfolder:

```
cd ansible
ansible-playbook -i inventory/ playbook-setup-es.yml
```

Ansible has dynamic inventory script `ec2.py` which require AWS credentials to be defined.



## Check Elasticsearch up and running

To check if the cluster works properly run the command:

```
# curl -X GET 10.8.1.10:9200/_cat/nodes?v
ip        heap.percent ram.percent cpu load_1m load_5m load_15m node.role master name
10.8.1.46           16          93   0    0.47    0.30     0.14 mdi       -      10.8.1.46
10.8.1.96           15          94   1    0.47    0.29     0.14 mdi       *      10.8.1.96
10.8.1.10           21          91   1    0.39    0.31     0.17 mdi       -      10.8.1.10
```