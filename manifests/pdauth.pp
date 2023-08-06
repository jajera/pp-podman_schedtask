# @summary manage pagerduty file presence on the system.
#
# @param names
#   Desired directories/files prerequisite to be used by pagerduty.
#
class pagerduty::file (
  Hash $names = {},
) {
  create_resources('file', $names)
}
