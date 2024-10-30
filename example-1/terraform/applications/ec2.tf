resource "aws_instance" "example" {
  ami           = "ami-06b21ccaeff8cd686"  # Need to Replace AMI ID based on our region 
  instance_type = "t2.micro"               # Change instance type if needed

  tags = {
    Name = "yo_kash_projetc_fresh_Test_1"                # Optional: Tag for identification
  }
}
