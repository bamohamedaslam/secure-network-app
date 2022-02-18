# secure-network-app

Repository to manage automation codes for Crayon Data assessment.

<![Architecture Diagram](https://docs.google.com/drawings/d/e/2PACX-1vRfwS7z1a29m_4QhJ6W5wL9m2FfF6QWYQixJA13G6LZc2FrdXI0ZTfI9Nxl-f01VrJgFEdGKY0f8ZYj/pub?w=1936&h=826)>

Terraform automation to setup infrastructure with AWS components like VPC, Subnets, Application Load Balancer, Auto Scaling Group, EC2, Security Groups, etc.
The end target node has the application to be served to client and has to be securely managed.

Squid:
The request inbound/outbounds are controlled by Squid proxy setup on each node. The requests are then re-routed by firewalls to the Nginx server.
Ingress/Egress DNS/IPs are whitelisted on the Squid configurations which allows the server only to connect with certain domains.

Nginx:
Receives the request and serves the application response. Multi-layered proxy enables the response to hide critical response headers and data being passed to client browser.
Proxy caching allows faster serving of data without CDN.

Load Balancing:
Both 80, 443 are listened but any requests to 80 will be redirected to 443 so as to have SSL communication open.
The applications are deployed on auto-scaling groups so any heavy increase in traffic can let the group scale the nodes and serve the client request.
The infra automations are developed in a way that even the subnets can be increased easily without major change in terraform code.

Tech Stack:<br/>
Cloud - AWS <br/>
Web server - Nginx<br/>
SCM - Git<br/>
NAT - Squid server<br/>

How to run the terraform:

1. Install and configure AWS CLI using <https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html>
2. Configure AWS accounts in AWS CLI.
3. Clone this repository.
4. Run "terraform init" to initiatise all the terraform modules.
5. Run "terraform plan" to display the dry run of terrafrom execution.
6. If the plan is succcessful and validated, run "terraform apply" to perform automated infrastructure setup.
