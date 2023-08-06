# @summary manage podman file presence on the system.
#
# @param names
#   Desired directories/files prerequisite to be used by podman.
#
class podman::file (
  Hash $names = {},
) {
  create_resources('file', $names)
}
