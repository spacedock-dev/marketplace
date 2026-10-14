#!/bin/sh
# Pins every extension entry of .claude-plugin/marketplace.json to its repository's
# newest release, prereleases included: the call edge install.sh makes, so the plugin
# matches the program it installs. Newest means most recently created, not highest
# version. Prints "name old -> new"; commit the result on the edge branch yourself.
# Needs gh (logged in) and jq.
set -eu

file="$(dirname "$0")/../.claude-plugin/marketplace.json"
tab="$(printf '\t')"
failed=0

entries="$(jq -r '.plugins[] | select(.name != "spacedock") | [.name, .source.url, (.source.path // "."), .source.ref] | join("\t")' "$file")"
while IFS="$tab" read -r name url path old; do
	repo="${url#https://github.com/}"; repo="${repo%.git}"
	tag="$(gh api "repos/$repo/releases?per_page=1" --jq '.[0].tag_name')"
	version="${tag#v}"
	manifest="$(gh api "repos/$repo/contents/$path/.claude-plugin/plugin.json?ref=$tag" --jq '.content' | base64 -d | jq -r '.version')"
	if [ "$manifest" != "$version" ]; then
		echo "$name: release $tag carries a plugin manifest at $manifest; left at $old" >&2
		failed=1
		continue
	fi
	if [ "$tag" = "$old" ]; then
		echo "$name $old unchanged"
		continue
	fi
	jq --arg n "$name" --arg ref "$tag" --arg v "$version" \
		'(.plugins[] | select(.name == $n)) |= (.source.ref = $ref | .version = $v)' "$file" > "$file.new"
	mv "$file.new" "$file"
	echo "$name $old -> $tag"
done <<EOT
$entries
EOT
exit "$failed"
