---
description: Weekly check of GitHub releases for the tools listed in readme.md; opens one pull request bumping all outdated versions.
on:
  schedule: weekly
  workflow_dispatch:
model: gpt-6-luna
permissions:
  contents: read
  copilot-requests: write
  pull-requests: read
tools:
  github:
    mode: gh-proxy
    toolsets: [repos]
  bash: true
  edit:
network:
  allowed:
    - defaults
safe-outputs:
  create-pull-request:
    title-prefix: "[tool-updates] "
    labels: [dependencies]
    draft: false
    allowed-files:
      - readme.md
      - "**/Dockerfile"
    protected-files: allowed
    max: 1
  noop:
---

# Tool Version Updates

Keep the tool versions used by the Docker images up to date.

## Steps

1. Read `readme.md`. The `tool versions` code block lists `NAME_VERSION="x.y.z"` variables, and the `tool sources` table maps each variable to its GitHub repository URL.
2. For each variable, find the latest **stable** version of its repository, in this order:
   1. The latest GitHub release: `gh api repos/<owner>/<repo>/releases/latest` (ignores drafts and pre-releases).
   2. If the repository has no releases (this is the case for `adamralph/minver`, which only publishes tags and NuGet packages), use tags instead: `gh api "repos/<owner>/<repo>/tags?per_page=100" --jq '.[].name'`. Keep only tags that are plain stable semver (`x.y.z`, with an optional leading `v`); discard any tag with a suffix such as `-alpha`, `-rc` or `-beta`. Pick the highest by semver comparison, not by list order.
   
   Strip a leading `v` to get the version. If neither a release nor a stable tag is found, skip the tool and mention it in the PR body.
   - For `kubernetes/kubernetes`, use the latest stable release tag (not alpha/beta/rc).
3. Compare with the current version. Only update when the latest version is strictly newer (semver comparison).
4. For each outdated tool, update the value everywhere it is defined: `readme.md` and every `Dockerfile` in the repository that sets the same variable (use `grep -rn "NAME_VERSION" --include=Dockerfile --include=readme.md .`). Keep the existing syntax and quoting; change only the version number. Do not modify unrelated lines.
5. If no tool has a newer release, call `noop` with a short reason.
6. Otherwise create a single pull request containing all updates. The body must include a table: tool, repository, old version, new version, and a link to the release page or tag link. Mention any major version bumps prominently, since they may need manual verification of the download URLs in the Dockerfiles.
