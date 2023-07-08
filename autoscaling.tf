resource "aws_launch_configuration" "my_config" {
  name_prefix     = "capstone-config"
  image_id        = "ami-06ca3ca175f37dd66"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.my_sg.id]
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.my_sg.id]
  }
}

resource "aws_autoscaling_group" "my_asg" {
  vpc_zone_identifier       = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id, aws_subnet.subnet_c.id]
  launch_configuration      = aws_launch_configuration.my_config.name
  desired_capacity          = 1
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 30
  health_check_type         = "EC2"
  lifecycle {
    create_before_destroy = true
  }
}
