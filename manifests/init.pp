# # @summary orchestrated include sequence and entry point
# #
include 'podman::package'
include 'podman::file'
include 'pagerduty::file'
include 'podman::container'
include 'systemd::scheduler'
