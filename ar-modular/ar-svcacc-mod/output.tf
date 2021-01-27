output "push_service_account" {
  value = google_service_account.robotpush.email
}

output "pull_service_account" {
  value = google_service_account.robotpull.email
}

output "service_account_push_key" {
  value = google_service_account_key.pushkey.private_key
}