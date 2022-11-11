provider "yandex" {
  // path to service account key file
  service_account_key_file = "../yc.json"

  cloud_id  = "your_cloud_id"
  folder_id = "your_folder_id"
  zone      = "ru-central1-a"
}
