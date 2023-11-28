resource "cloudflare_device_posture_rule" "warp" {
  account_id  = var.cloudflare_account_id
  name        = var.env == "prod" ? "Cloudflare WARP" : "Cloudflare WARP (${var.env})"
  type        = "warp"
  description = "Check device is using Cloudflare WARP"
  schedule    = "24h"
  expiration  = "24h"
}

resource "cloudflare_device_posture_rule" "gateway" {
  account_id  = var.cloudflare_account_id
  name        = var.env == "prod" ? "Cloudflare ZT Gateway" : "Cloudflare ZT Gateway (${var.env})"
  type        = "gateway"
  description = "Check device is using Cloudflare Zero Trust Gateway"
  schedule    = "24h"
  expiration  = "24h"
}

resource "cloudflare_device_posture_rule" "firewall_windows" {
  account_id  = var.cloudflare_account_id
  name        = var.env == "prod" ? "Firewall (Windows)" : "Firewall (Windows) (${var.env})"
  type        = "firewall"
  description = "Check Windows firewall is enabled"
  schedule    = "24h"
  expiration  = "24h"

  match {
    platform = "windows"
  }

  input {
    enabled = true
  }
}

resource "cloudflare_device_posture_rule" "firewall_macos" {
  account_id  = var.cloudflare_account_id
  name        = var.env == "prod" ? "Firewall (macOS)" : "Firewall (macOS) (${var.env})"
  type        = "firewall"
  description = "Check macOS firewall is enabled"
  schedule    = "24h"
  expiration  = "24h"

  match {
    platform = "mac"
  }

  input {
    enabled = true
  }
}

resource "cloudflare_device_posture_rule" "disk_encryption_windows" {
  account_id  = var.cloudflare_account_id
  name        = var.env == "prod" ? "Disk Encryption (Windows)" : "Disk Encryption (Windows) (${var.env})"
  type        = "disk_encryption"
  description = "Check BitLocker is enabled"
  schedule    = "24h"
  expiration  = "24h"

  match {
    platform = "windows"
  }

  input {
    check_disks = ["C:"]
  }
}

resource "cloudflare_device_posture_rule" "disk_encryption_macos" {
  account_id  = var.cloudflare_account_id
  name        = var.env == "prod" ? "Disk Encryption (macOS)" : "Disk Encryption (macOS) (${var.env})"
  type        = "disk_encryption"
  description = "Check FileVault is enabled"
  schedule    = "24h"
  expiration  = "24h"

  match {
    platform = "mac"
  }

  input {
    check_disks = ["/", "/System/Volumes/Data"]
  }
}

resource "cloudflare_device_posture_rule" "os_version_windows" {
  account_id  = var.cloudflare_account_id
  name        = var.env == "prod" ? "OS Version (Windows)" : "OS Version (Windows) (${var.env})"
  type        = "os_version"
  description = "Check Windows version meets or exceeds minimum"
  schedule    = "24h"
  expiration  = "24h"

  match {
    platform = "windows"
  }

  input {
    version  = "10.0.22621"
    operator = ">="
  }
}

resource "cloudflare_device_posture_rule" "os_version_macos" {
  account_id  = var.cloudflare_account_id
  name        = var.env == "prod" ? "OS Version (macOS)" : "OS Version (macOS) (${var.env})"
  type        = "os_version"
  description = "Check macOS version meets or exceeds minimum"
  schedule    = "24h"
  expiration  = "24h"

  match {
    platform = "mac"
  }

  input {
    version  = "13.5.1"
    operator = ">="
  }
}

resource "cloudflare_device_posture_rule" "os_version_ios" {
  account_id  = var.cloudflare_account_id
  name        = var.env == "prod" ? "OS Version (iOS)" : "OS Version (iOS) (${var.env})"
  type        = "os_version"
  description = "Check iOS version meets or exceeds minimum"
  schedule    = "24h"
  expiration  = "24h"

  match {
    platform = "ios"
  }

  input {
    version  = "17.1.1"
    operator = ">="
  }
}

resource "cloudflare_device_posture_rule" "os_version_android" {
  account_id  = var.cloudflare_account_id
  name        = var.env == "prod" ? "OS Version (Android)" : "OS Version (Android) (${var.env})"
  type        = "os_version"
  description = "Check Android version meets or exceeds minimum"
  schedule    = "24h"
  expiration  = "24h"

  match {
    platform = "android"
  }

  input {
    version  = "14.0.0"
    operator = ">="
  }
}
