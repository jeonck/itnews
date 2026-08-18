#!/usr/bin/env bash
# Verifies that today's briefing exists, is dated correctly for US Central, and
# is actually included in the Hugo build. Run this before committing a post.
#
# The failure this guards against: a post dated even one second in the future is
# silently dropped by Hugo, so the site publishes with no new entry and nothing
# errors out.
set -uo pipefail

today=$(TZ=America/Chicago date +%F)
now=$(TZ=America/Chicago date +%Y-%m-%dT%H:%M:%S%:z)
post="content/posts/${today}.md"
fail=0

if [ ! -f "$post" ]; then
  echo "FAIL: $post does not exist."
  echo "      Today in US Central is $today. The filename must be that date —"
  echo "      never a date inferred from git history or from UTC."
  exit 1
fi

date_line=$(grep -m1 '^date:' "$post" | sed 's/^date: *//')
if [ -z "$date_line" ]; then
  echo "FAIL: $post has no 'date:' line in its front matter."
  fail=1
elif [[ "$date_line" != "$today"T* ]]; then
  echo "FAIL: $post is dated '$date_line' but today in US Central is $today."
  fail=1
elif [[ "$date_line" > "$now" ]]; then
  echo "FAIL: $post is dated '$date_line', which is in the future (now $now)."
  echo "      Hugo excludes future-dated posts from the build."
  fail=1
fi

if command -v hugo >/dev/null 2>&1; then
  if ! hugo --minify --quiet; then
    echo "FAIL: hugo build reported errors."
    fail=1
  elif ! hugo list all | grep -q "^${post},"; then
    echo "FAIL: $post is not in the build output (future-dated, or draft: true)."
    fail=1
  fi
else
  echo "WARN: hugo is not installed here; skipped build verification."
fi

if [ "$fail" -eq 0 ]; then
  echo "OK: $post is dated $date_line and is included in the build."
fi
exit "$fail"
