#!/bin/bash

# This script extracts the GSID from a Salesforce Lightning URL.
# It is designed to be compatible with both Linux and macOS.
#
# It requires 'jq' to be installed for JSON parsing.
# You can install jq using:
#   On macOS: brew install jq
#   On Debian/Ubuntu: sudo apt-get install jq
#   On CentOS/RHEL: sudo yum install jq

# Immediately exit if any command fails
set -e

# --- Pre-flight check for jq ---
if ! command -v jq &> /dev/null; then
    echo "Error: The 'jq' command is not found." >&2
    echo "Please install jq to use this script (e.g., 'brew install jq')." >&2
    exit 1
fi

# --- Script Logic ---
input_url="$1"

# Check if a URL was provided as an argument
if [ -z "$input_url" ]; then
  echo "Usage: $0 <url>" >&2
  exit 1
fi

# 1. Extract the Base64 encoded string after the '#'
encoded_str=$(echo "$input_url" | cut -d'#' -f2)
if [ -z "$encoded_str" ]; then
  echo "Error: Could not find the encoded part of the URL (everything after '#')." >&2
  exit 1
fi

# 2. Decode the string.
# First, determine the correct base64 decode command based on the OS.
if [[ "$(uname)" == "Darwin" ]]; then
  # macOS
  base64_decode_cmd="base64 -d"
else
  # GNU/Linux
  base64_decode_cmd="base64 --decode"
fi

# URL-decode the outer Base64 string and then pipe to the base64 command.
json_output=$(printf '%b' "${encoded_str//%/\\x}" | $base64_decode_cmd 2>/dev/null)

if [ -z "$json_output" ]; then
  echo "Error: Failed to decode the Base64 string. Check for malformed URL." >&2
  exit 1
fi

# 3. Use jq to parse the JSON and get the 'address' URL.
# The '|| true' prevents the script from exiting if jq returns no output before our check.
address_url=$(echo "$json_output" | jq -r '.attributes.address' || true)

if [ -z "$address_url" ] || [ "$address_url" == "null" ]; then
  echo "Error: Could not find the 'address' URL within the decoded data." >&2
  exit 1
fi

# 4. *** THE FIX ***
# The extracted URL may still have URL-encoded characters. Decode them now.
decoded_address_url=$(printf '%b' "${address_url//%/\\x}")

# 5. Extract the 'cid' value from the now-decoded address URL using sed.
gsid=$(echo "$decoded_address_url" | sed -n 's/.*cid=\([^&]*\).*/\1/p')

# 6. Print the final result. On success, it prints only the GSID.
if [ -n "$gsid" ]; then
  echo "$gsid"
else
  echo "GSID not found in the final URL." >&2
  exit 1
fi
