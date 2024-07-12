<!--
# Copyright (c) 2024, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
-->

# **OCI Quick start to create the required resources for a Private Endpoint enabled Visual Builder instance**

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/vlalan-code/vb/releases/latest/download/private-endpoint-resources.zip)


## Introduction

We need to have some pre-requisite resources to be present in the customer tenancy so that it is easier for customers to provide the correct subnet while creating a Private Endpoint enabled Visual Builder instance. 

This stack automates the following:

* Creating a VCN
* Creating a public and private subnet by dividing the CIDR range for the VCN equally
* Creating route tables for private and public subnet
* Adding security list and exposing port 443 for inter subnet communication and port 443 of public subnet
* Adding port 1521 and 1522 for ingress with private subnet to access ATP instance 
* Creating 1 Internet Gateway (route in public subnet only) , 1 Service Gateway and 1 NAT Gateway (route in private subnet only)
* Optionally creating a Public Load Balancer and adds listener and backend set on protocol TCP and port 443.

## Prerequisites
- Permission to `manage` the resources mentioned above in your Oracle Cloud Infrastructure tenancy
- Quota to create the following resources: 1 VCN, 2 subnets, 1 Internet Gateway, 1 NAT Gateway, 1 Service Gateway, 1 Load Balancer

If you don't have the required permissions and quota, contact your tenancy administrator. See [Policy Reference](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Reference/policyreference.htm), [Service Limits](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm), [Compartment Quotas](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcequotas.htm).

## Using this stack

1. Click on above Deploy to Oracle Cloud button which will redirect you to OCI console and prompt a dialogue box with further steps on deploying this application.
2. Configure the variables for the infrastructure resources that this stack will create when you run the apply job for this execution plan.

Note: For more details on Visual Builder, please refer
https://docs.oracle.com/en/cloud/paas/app-builder-cloud/index.html