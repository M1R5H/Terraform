provider "google" {
    #credentials = "../../../global/access.json"
    project = "aerobic-bonus-270814"
    region  = "europe-west2"
    zone    = "europe-west2-a"
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"
  credentials = "../../../global/access.json"

}

