resource "cloudflare_device_posture_rule" "warp" {
  account_id  = var.cloudflare_account_id
  name        = "Cloudflare WARP"
  type        = "warp"
  description = "Check device is using Cloudflare WARP"
  schedule    = "24h"
  expiration  = "24h"
}

resource "cloudflare_device_posture_rule" "gateway" {
  account_id  = var.cloudflare_account_id
  name        = "Zero Trust Gateway"
  type        = "gateway"
  description = "Check device is using Cloudflare Zero Trust Gateway"
  schedule    = "24h"
  expiration  = "24h"
}

resource "cloudflare_device_posture_rule" "firewall_windows" {
  account_id  = var.cloudflare_account_id
  name        = "Firewall (Windows)"
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
  name        = "Firewall (macOS)"
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
  name        = "Disk Encryption (Windows)"
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
  name        = "Disk Encryption (macOS)"
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
  name        = "OS Version (Windows)"
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
  name        = "OS Version (macOS)"
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
  name        = "OS Version (iOS)"
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
  name        = "OS Version (Android)"
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