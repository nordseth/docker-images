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
    max: 2
  noop:
    report-as-issue: false
---

# Tool Version Updates

Keep the tool versions used by the Docker images up to date.

## Steps

1. Read `readme.md`. The `tool versions` code block lists `NAME_VERSION="x.y.z"` variables, and the `tool sources` table maps each variable to its GitHub repository URL.
2. For each variable, collect the **stable** versions of its repository, in this order of preference:
   1. GitHub releases: `gh api "repos/<owner>/<repo>/releases?per_page=100" --jq '.[] | select(.draft==false and .prerelease==false) | .tag_name'`.
   2. If the repository has no releases (this is the case for `adamralph/minver`, which only publishes tags and NuGet packages), use tags: `gh api "repos/<owner>/<repo>/tags?per_page=100" --jq '.[].name'`.
   
   Keep only plain stable semver versions (`x.y.z`, with an optional leading `v`, which you strip); discard any suffix such as `-alpha`, `-rc` or `-beta`. Always compare by semver, never by list order. If no stable version is found, skip the tool and mention it in the PR body.
3. For each tool, determine up to two candidates relative to the current version:
   - **Minor/patch update**: the highest stable version with the **same major** as the current version, if it is strictly newer.
   - **Major update**: the highest stable version overall, if its major is greater than the current major.
4. Before opening anything, run `gh pr list --state open --search "[tool-updates] in:title"` and skip tools already covered by an open PR of the same kind with the same target version.
5. For each PR, update the value everywhere it is defined: `readme.md` and every `Dockerfile` that sets the same variable (use `grep -rn "NAME_VERSION" --include=Dockerfile --include=readme.md .`). Keep the existing syntax and quoting; change only the version number. Do not modify unrelated lines.
6. Open at most two pull requests:
   - **Batch PR** with all minor/patch updates, titled `Update <tool> to <version>` style (summarize). It must never contain a major bump, so tools with a pending major stay on their current major until the major PR is merged.
   - **Major PR** with all major bumps, titled starting with `Major: `. In the body, summarize breaking changes from each release's notes and note that the download URLs and archive names in the Dockerfiles may need manual verification.
   
   Each PR body must include a table: tool, repository, old version, new version, and a link to the release or tag.
7. If there is nothing to update (or everything is already covered by open PRs), call `noop` with a short reason.
