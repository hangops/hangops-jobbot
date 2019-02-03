resource "aws_iam_role" "sntxrr-cluster" {
  name = "terraform-eks-sntxrr-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Worker nodes
resource "aws_iam_role_policy_attachment" "sntxrr-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.sntxrr-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "sntxrr-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.sntxrr-cluster.name}"
}

resource "aws_iam_role" "sntxrr-node" {
  name = "terraform-eks-sntxrr-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "sntxrr-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.sntxrr-node.name}"
}

resource "aws_iam_role_policy_attachment" "sntxrr-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.sntxrr-node.name}"
}

resource "aws_iam_role_policy_attachment" "sntxrr-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.sntxrr-node.name}"
}

resource "aws_iam_instance_profile" "sntxrr-node" {
  name = "terraform-eks-sntxrr"
  role = "${aws_iam_role.sntxrr-node.name}"
}
