#!/bin/bash

export OS_PROJECT_NAME="My Openstack project name"
#alternatively, set OS_PROJECT_ID: export OS_PROJECT_ID=062592bf4bb446b286be66ed7e9e68c4 

export OS_USER_DOMAIN_NAME="default"
export OS_DOMAIN_NAME="default"
export OS_REGION_NAME="RegionOne"
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3

export NAME="k8s-demo"
export KEY='My OS Key Name'
export IMAGE="Ubuntu Server 18.04 64bit (29.05.2018)"
export EXTERNAL_NETWORK="ext-net-201"
export FLOATING_IP_POOL="ext-net-201"
export FLOATING_IP_NETWORK_UUID="33814-06-4a-89-11e4701"
export USE_LOADBALANCER="True"
export NODE_FLAVOR="m1.xlarge"
export NODE_COUNT="10"
export NODE_BOOT_FROM_VOLUME="False"
export NODE_EXTRA_VOLUME="False"
export MASTER_BOOT_FROM_VOLUME="False"
export MASTER_FLAVOR="m1.large"
export INCLUDE_HELM="False"

export SUBNET_CIDR="10.8.10.0/24"
export POD_SUBNET_CIDR="10.96.0.0/16"
export CLUSTER_DNS_IP="10.96.0.10"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cmd="$1"
settings="$DIR/run-demo-settings.yaml"

K8S_ON_OPENSTACK_DIR=../k8s-on-openstack/

case $cmd in
    create)
     (cd $K8S_ON_OPENSTACK_DIR ; ansible-playbook site.yaml)
	 ansible-playbook --extra-vars "@$settings" create.yaml
    ;;
    destroy)
	 ansible-playbook --extra-vars "@$settings" destroy.yaml
     (cd $K8S_ON_OPENSTACK_DIR ; ansible-playbook destroy.yaml)
    ;;
    *)    # unknown option - just set env
     echo "Unknown command ($cmd), setting environment variables only"
    ;;
esac