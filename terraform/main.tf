resource "aws_eks_cluster" "sntxrr" {
  name            = "${var.cluster-name}"
  role_arn        = "${aws_iam_role.sntxrr-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.sntxrr-cluster.id}"]
    subnet_ids         = ["${aws_subnet.sntxrr.*.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.sntxrr-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.sntxrr-cluster-AmazonEKSServicePolicy",
  ]
}


