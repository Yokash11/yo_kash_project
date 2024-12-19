resource "aws_instance" "ec2_instace" {
  ami           = "ami-06b21ccaeff8cd686"  # Need to Replace AMI ID based on our region 
  instance_type = "t2.micro"               # Change instance type if needed

  tags = {
    Name = "${var.environment}_ec2_instance"                
  }
}
