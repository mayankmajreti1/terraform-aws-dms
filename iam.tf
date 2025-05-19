resource "aws_iam_role" "dms_vpc_role" {
  name               = "dms-vpc-role"
  assume_role_policy = data.aws_iam_policy_document.dms_assume_role.json
}

resource "aws_iam_role_policy_attachment" "dms_vpc_role_attachment" {
  role       = aws_iam_role.dms_vpc_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
}

resource "aws_iam_role_policy" "dms_cloudwatch_logs" {
  name   = "dms-cloudwatch-logs-policy"
  role   = aws_iam_role.dms_vpc_role.id
  policy = data.aws_iam_policy_document.dms_cloudwatch_logs.json
}