# Terraform Demo
This repository contains some basic demos of [Terraform](https://terraform.io), an infrastructure-as-code tool.  These demos cover:

- a standard VPC (private network) in AWS
- a dependent auto-scaling group of web servers (they will be launched within the VPC)
- a reusable module that creates VMware virtual machines (vSphere required)

### Prerequisites
Download Terraform [here](https://www.terraform.io/downloads.html).  Each download is simply a zip file with a compiled executable enclosed.  Extract that executable to the location of your choice and make sure its permissions are right (e.g. chmod 755).  Good locations include /usr/local/bin, ~/bin, or %userprofile%/bin if you're a Windows user.  Be sure to add this folder to your PATH.  For Windows users, you can change your path in the Control Panel, under User Accounts.  Choose your own Windows account and choose "Change my environment variables." Edit your PATH variable and add ";%USERPROFILE%\bin" to the end of it (including the semicolon).

You will need an AWS account, or a VMware vSphere account*, or both.  You can sign up for a free AWS account [here](https://aws.amazon.com/), and you'll get a year's worth of free-tier access to AWS services.  **BE AWARE** that AWS free-tier has limits.  These demos will cost money if you leave the resources that Terraform creates running.  However, with judicious use of your free-tier access, it's quite possible to learn a lot about the AWS platform over the course of one year.

You don't need Git, but you should use it.  You can download that [here](https://git-scm.com/downloads).

If you're setting up an AWS account (or you already have one), then you should be sure that the computer you're working on has your AWS credentials configured.  Check out [this guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) on how to configure your access and secret keys to the AWS API.

In order for Terraform to work, you will need these variables set, or an AWS credentials file (The default location is $HOME/.aws/credentials on Linux and OS X, or "%USERPROFILE%\.aws\credentials" for Windows users):

```bash
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_DEFAULT_REGION="us-east-1"
```

### Getting Started

Near the top of this page, you'll see a green button that says "clone or download."  Click on that, and then choose to download a zip of the repository.  Or, if you installed Git, you can clone it:

```bash
git clone https://github.com/gswallow/terraform-demo.git
```

In either case, wherever you clone or download your copy of the repository doesn't matter.  Just make sure it's in a place you'll be able to find later.

### Show Me the Easiest Thing to Do
The 'vpc' folder in this repository has no pre-requisites other than your AWS credentials.  Using the command-line of your choice (terminal or powershell), change directory into the vpc directory and run the following commands:

```bash
terraform init
terraform plan .
```

Terraform would create a rather large collection of resources!  As of time of this writing, it would create 39 separate resources including six networks, three NAT gateways, some SSH keys, a bastion host, and firewall rules (security groups). Running `terraform  plan` doesn't actually make any changes.  It shows what what it plans to do, and you can then choose whether you want to *apply*  those changes by running `terraform apply`.  This way, you can hit the brakes before steamrolling your existing infrastructure.  Go ahead and apply your changes:

```bash
terraform apply .
```

Note that Terraform still prompts whether you want to move forward.  Once it's done, it will output the IP address of the bastion host, the SSH key you can use to log into the bastion host with an SSH client** (built in, or PuTTY), and some other data.  Take a break here to read through Terraform's output -- what it created, what it spat out, etc.  You can always view the state information by running `terraform state` and `terraform output`:

```bash
terraform state list
aws_ami.ubuntu
aws_availability_zones.available
aws_caller_identity.current
aws_default_security_group.default
aws_eip.nat[0]
aws_eip.nat[1]
aws_eip.nat[2]
aws_instance.bastion
...

terraform state show aws_instance.bastion
...
```

Note, also, that there will be a new folder and a new file in your working directory.  The `.terraform` directory was created by `terraform init`, and it contains the provider modules that the state uses.  The `terraform.tfstate` file is important.  You don't want to lose this file, but you NEVER check this file into a Git repository.  At least be damned sure that it doesn't contain secrets if you check it into Git.  If you plan on using Terraform with a team, you will want to look at [remote state backends](https://www.terraform.io/docs/backends/types/remote.html) before doing any real work.  Most people who use AWS choose the S3 backend and if you do, you should read [that document](https://www.terraform.io/docs/backends/types/s3.html) carefully.

### Moving On
Now that we've created a stout VPC, let's create a web server farm. Change to the web-farm directory (make sure your VPC is still spun up) and run the two initial commands again:

```bash
terraform init
terraform plan .
```

This plan only creates seven resources at time of this writing, but some of them are pretty powerful.  We create an auto scaling group, which can be used to guarantee that hosts are always up.  We create a load balancer, which monitors the health of our web servers and directs HTTP traffic to them.  We create more firewall rules (security groups), protecting our web servers from attack.  We specify a launch configuration with user-data that automatically configures our web servers.  

In about five minutes (and six commands!), we've created a bomb-proof website that spans three different failure domains.  Pretty cool, eh?

Terraform will spit out the DNS name of the load balancer when it finishes.  You can copy that hostname and paste it into your browser.  You should be able to visit your website.

### Teardown
As stated in the beginning of this article, running eight servers is going to consume all of your free tier for the month in about three days.  You'll only need to view the website once, which should take about 30 seconds.  To destroy your resources, just run `terraform destroy`, in order:

- Run `terraform destroy .` in the web-farm directory.  Terraform will prompt if you really want to destroy your stuff.
- Run `terraform destroy .` in the vpc directory.  Answer 'yes' to the prompt.

### VMware
There's a VMware folder in this repository.  Terraform is capable of more than AWS wizardry -- it can talk to dozens of other systems through [providers](https://www.terraform.io/docs/providers/index.html), including VMware, Github, Microsoft Azure, Google Cloud, many popular open source databases, and even itself.  In fact, there's an example of Terraform talking to itself in the 'web-farm' state.

In order to run the VMware example, you'll need to know the layout of your VMware infrastructure (and have an account with privileges, of course).  These pre-requisites make the task of writing documentation impossible in this use case.  Note, however, that if you wanted to stand VMware up on your home lab and configure *nothing*, it's possible to completely build a VMware infrastructure (datastores, networks, folders; the works) using Terraform alone.

### Really Getting Started

Hashicorp's documentation is very user-friendly.  First off, there's [learn.hashicorp.com](https://learn.hashicorp.com/terraform/), which is written better than this example repository.  

The reference documentation is enough to go by.  First, learn what the commands (CLI) do:

https://www.terraform.io/docs/commands/index.html

Many commands, you'll rarely use (if you ever have to use them at all).  Next, check out the providers:

https://www.terraform.io/docs/providers/index.html

Each provider gives you data sources and resources.  A data source is something you can query (e.g. a route53 zone, an ACM certificate, a VMware Compute Cluster, or even a local file). A resource is something you create.  Each provider's page lays out the data sources on top of its menu, and providers towards the bottom.

Each resource is documented in nearly the same format: What it is, what parameters go into it, and what parameters it spits out.  What a resource spits out is just as important as what goes into it; sometimes you have to use these return parameters in other resources you create.  For example, I may create an SSL certificate with AWS's Automated Certificate Manager service (ACM), and then use the ARN of that certificate (its "computer name") in a load balancer that secures backend servers with it.  Who pays for SSL anymore?

Getting into more detailed usage, you can check out Terraform's configuration and interpolation commands.  These are all changing right now as Terraform is transitioning from v0.11 to v0.12, so don't get too invested.  If you browse around the contents of this repo,
you'll find a lot of examples of interpolation filters like `cidrhost` and `element`, conditional operations like using ternary operators and "count," and some looping tricks using the modulo operator (division remainder).

Once you get the hang of writing Terraform code, you should look into modules:

https://www.terraform.io/docs/configuration-0-11/modules.html

Writing Terraform modules allows you to set up a model resource (e.g. a VMware VM), and reuse that module as many times as you need.  For example, the VMware state in this repository allows you to scale from zero VMs to as many as you want just by changing the `vm_count` variable in a `.tfvars` file.  Rather than having to write code for each VM, we write the module once, and call it as many times as we need.

### Go Forth!
Infrastructure as code is a powerful concept.  Tracking infrastructure as code reduces mistakes, encourages peer review, and shortens delivery cycles.  Even if you have to spend a week cutting your teeth on your first Terraform state, spin it up and destroy it a dozen times.  You'll be amazed at what you can do with Terraform and other tools like Packer and Ansible once you get your first project working.
