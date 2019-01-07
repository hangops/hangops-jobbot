data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

# This data source is included for ease of sample architecture deployment
# and can be swapped out as necessary.
data "aws_region" "current" {}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  sntxrr-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.sntxrr.endpoint}' --b64-cluster-ca '${aws_eks_cluster.sntxrr.certificate_authority.0.data}' '${var.cluster-name}'
USERDATA
}

resource "aws_launch_configuration" "sntxrr" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.sntxrr-node.name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "m4.large"
  name_prefix                 = "terraform-eks-sntxrr"
  security_groups             = ["${aws_security_group.sntxrr-node.id}"]
  user_data_base64            = "${base64encode(local.sntxrr-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}