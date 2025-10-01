# ALB
resource "aws_lb" "alb" {
  name               = "wp-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.public_subnet_1, var.public_subnet_2]
  security_groups    = [var.alb_sg_id]
  enable_deletion_protection = false

  tags = { Name = "wp-alb" }
}

# Target group (instances)
resource "aws_lb_target_group" "wp_tg" {
  name     = "wp-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
  enabled             = true
  protocol            = "HTTP"
  port                = "traffic-port"
  path                = "/health.html"
  matcher             = "200-399"
  interval            = 30
  timeout             = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  }
}

# Attach EC2s
resource "aws_lb_target_group_attachment" "app1_attach" {
  target_group_arn = aws_lb_target_group.wp_tg.arn
  target_id        = var.app1_id
  port             = var.http
}

resource "aws_lb_target_group_attachment" "app2_attach" {
  target_group_arn = aws_lb_target_group.wp_tg.arn
  target_id        = var.app2_id
  port             = var.http
}

# HTTP listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.http
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wp_tg.arn
  }
}



