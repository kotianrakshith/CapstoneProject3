resource "aws_launch_template" "my_template" {
  name = "capstone_template"
  image_id = "ami-06ca3ca175f37dd66"
  instance_type = "t2.micro"
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.my_sg.id]
  }
}

resource "aws_autoscaling_group" "my_asg" {
  name                      = "capstone_asg"
  max_size                  = 3
  min_size                  = 1
  health_check_type         = "EC2"
  desired_capacity          = 1
  vpc_zone_identifier       = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id, aws_subnet.subnet_c.id]
  launch_template {
    id      = aws_launch_template.my_template.id
  }
}
