resource "aws_security_group" "sntxrr-cluster" {
  name        = "terraform-eks-sntxrr-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.sntxrr.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "terraform-eks-sntxrr"
  }
}

# OPTIONAL: Allow inbound traffic from your local workstation external IP
#           to the Kubernetes. You will need to replace A.B.C.D below with
#           your real IP. Services like icanhazip.com can help you find this.
resource "aws_security_group_rule" "sntxrr-cluster-ingress-workstation-https" {
  cidr_blocks       = ["A.B.C.D/32"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.sntxrr-cluster.id}"
  to_port           = 443
  type              = "ingress"
}

# Worker nodes
resource "aws_security_group" "sntxrr-node" {
  name        = "terraform-eks-sntxrr-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${aws_vpc.sntxrr.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
      "Name", "terraform-eks-sntxrr-node",
      "kubernetes.io/cluster/${var.cluster-name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "sntxrr-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.sntxrr-node.id}"
  source_security_group_id = "${aws_security_group.sntxrr-node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "sntxrr-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sntxrr-node.id}"
  source_security_group_id = "${aws_security_group.sntxrr-cluster.id}"
  to_port                  = 65535
  type                     = "ingress"
}

# Worker nodes ingress
resource "aws_security_group_rule" "sntxrr-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sntxrr-cluster.id}"
  source_security_group_id = "${aws_security_group.sntxrr-node.id}"
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_autoscaling_group" "sntxrr" {
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.sntxrr.id}"
  max_size             = 2
  min_size             = 1
  name                 = "terraform-eks-sntxrr"
  vpc_zone_identifier  = ["${aws_subnet.sntxrr.*.id}"]

  tag {
    key                 = "Name"
    value               = "terraform-eks-sntxrr"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
