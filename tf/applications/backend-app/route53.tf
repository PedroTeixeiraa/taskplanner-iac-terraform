resource "aws_route53_record" "taskplanner-api_record" {
  zone_id = var.route53_zone_id
  name    = var.route53_record_name
  type    = "A"

  alias {
    name                   = aws_lb.task_planner_lb.dns_name
    zone_id                = aws_lb.task_planner_lb.zone_id
    evaluate_target_health = true
  }
}