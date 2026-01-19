#!/usr/bin/env bash
echo "<!-- This file is generated automatically. Manual edits will be overwritten -->"
echo "# my github gists"
echo ""

gists=$(gh api /gists --paginate)

echo $gists |
    jq -r '
    sort_by(.files | keys[0] | ascii_downcase) |

    .[] |
    (.files | keys[0]) as $name |
    (.html_url) as $url |
    (.description // "") as $desc |

    "- [**\($name)**](\($url))  "
    + "\n"
    + (if $desc != "" then "\($desc)\n" else "" end)
  '
