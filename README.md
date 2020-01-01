# Deploying a 3-tier web application with AWS Cloudformation

This repository provides a set of YAML templates and linux shell scripts for deploying a 3-tier web application to [Amazon EC2 instances](https://aws.amazon.com/ec2/) with [AWS CloudFormation](https://aws.amazon.com/cloudformation/)

## Overview
![infrastructure-overview](images/staging-architecture.png)

## Templates

### Categories
* [Root](#root)
* [VPC](#vpc)
* [Storage](#storage)
* [WebServer](#webserver)

### Root
[Back to Top](#overview)

This is the master template that will call all the templates.
These are good to build out a full environment without having to run each template individually.
Coupled with a custom parameters JSON file can give you a one command solution to a complex setup and eliminate the need to duplicate code.

<table width="100%">
    <tr>
        <th align="left" colspan="2"><h4><a href="https://github.com/klezca/aws-infrastructure/blob/master/root.yaml">Infrastructure</a></h4></th>
    </tr>
    <tr>
        <td width="100%" valign="top">
            <p>Select the foundational pieces for building out an infrastructure from the ground up.</p>
            <h6>Create Details</h6>
            <ol>
                <li>VPC</li>
                <li>Storage</li>
                <li>Web Server</li>
            </ol>
        </td>
        <td  nowrap width="200" valign="top">
            <table>
                <tr>
                    <th align="left">View Diagram</th>
                </tr>
                <tr>
                    <td>
                        <a href="images/root.JPG" target="_blank"><img src="images/root.JPG" width:100% alt="View Diagram"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

### VPC
[Back to Top](#overview)

<table width="100%">
    <tr>
        <th align="left" colspan="2"><h4><a href="https://github.com/klezca/aws-infrastructure/blob/master/infrastructure/vpc.yaml">VPC</a></h4></th>
    </tr>
    <tr>
        <td width="100%" valign="top">
            <p>Select the foundational pieces for building out a VPC network from the ground up.</p>
            <h6>Create Details</h6>
            <ol>
                <li>VPC</li>
                <li>Internet Gateway</li>
                <li>NAT Gateway</li>
                <li>3 Public Subnets</li>
                <li>3 Private Subnets</li>
                <li>Public/Private Route Table</li>
                <li>Security Groups</li>
            </ol>
        </td>
        <td  nowrap width="200" valign="top">
            <table>
                <tr>
                    <th align="left">View Diagram</th>
                </tr>
                <tr>
                    <td>
                        <a href="images/vpc.jpg" target="_blank"><img src="images/vpc.jpg" width:100% alt="View Diagram"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

### Storage
[Back to Top](#overview)

<table width="100%">
    <tr>
        <th align="left" colspan="2"><h4><a href="https://github.com/klezca/aws-infrastructure/blob/master/infrastructure/storage.yaml">Storage</a></h4></th>
    </tr>
    <tr>
        <td width="100%" valign="top">
            <p>Select the foundational pieces for building out the storage from the ground up.</p>
            <h6>Create Details</h6>
            <ol>
                <li>KMS key</li>
                <li>Aurora cluster</li>
                <li>Elasticache cluster</li>
                <li>Aurora Alarms</li>
            </ol>
        </td>
        <td  nowrap width="200" valign="top">
            <table>
                <tr>
                    <th align="left">View Diagram</th>
                </tr>
                <tr>
                    <td>
                        <a href="images/storage.JPG" target="_blank"><img src="images/storage.JPG" width:100% alt="View Diagram"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

### WebServer
[Back to Top](#overview)

<table width="100%">
    <tr>
        <th align="left" colspan="2"><h4><a href="https://github.com/klezca/aws-infrastructure/blob/master/infrastructure/webserver.yaml">Web Server</a></h4></th>
    </tr>
    <tr>
        <td width="100%" valign="top">
            <p>Select the foundational pieces for building out a web server, application load balancer, autoscaling groups and a route 53 record for the application load balancer from the ground up.</p>
            <h6>Create Details</h6>
            <ol>
             <li>EC2 Launch Configuration</li>
             <li>Autoscaling group</li>
             <li>Application load balancer</li>
             <li>Route 53 A record for application load balancer</li>
            </ol>
        </td>
        <td  nowrap width="200" valign="top">
            <table>
                <tr>
                    <th align="left">View Diagram</th>
                </tr>
                <tr>
                    <td>
                        <a href="images/webserver.JPG" target="_blank"><img src="images/webserver.JPG" width:100% alt="View Diagram"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>