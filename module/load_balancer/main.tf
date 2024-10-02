resource "aws_lb_target_group" "target_group" {
    health_check {
      interval = 10
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
      healthy_threshold = 5
      

    }
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = var.vpc_id
}

resource "aws_lb" "alb" {
    
  name               = var.alb_name
  internal           = var.internal
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  subnets            = var.subnet_id
  security_groups    = var.sg_id

  tags = {
    Name = var.alb_name
  }
}



resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"

  }
}

resource "aws_lb_target_group_attachment" "ec2_attach" {
  count            = var.ec2_count
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.ec2_id[count.index]
  port             = 80
}