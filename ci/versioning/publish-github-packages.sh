#!/bin/bash
set -euo pipefail

PACKAGE_PATH="packages/kumo"
PACKAGE_MANIFEST="${PACKAGE_PATH}/package.json"
PACKAGE_SCOPE="${GITHUB_REPOSITORY_OWNER:-conservationtv}"
PACKAGE_SCOPE="${PACKAGE_SCOPE,,}"
PACKAGE_NAME="@${PACKAGE_SCOPE}/kumo"
ORIGINAL_MANIFEST=$(mktemp)

cp "$PACKAGE_MANIFEST" "$ORIGINAL_MANIFEST"
trap 'cp "$ORIGINAL_MANIFEST" "$PACKAGE_MANIFEST"; rm -f "$ORIGINAL_MANIFEST"' EXIT

pnpm --filter @cloudflare/kumo build

PACKAGE_NAME="$PACKAGE_NAME" node --input-type=module <<'NODE'
import { readFile, writeFile } from "node:fs/promises";

const manifestPath = "packages/kumo/package.json";
const manifest = JSON.parse(await readFile(manifestPath, "utf8"));

manifest.name = process.env.PACKAGE_NAME;
manifest.publishConfig = {
  ...manifest.publishConfig,
  access: "public",
  registry: "https://npm.pkg.github.com",
};

await writeFile(manifestPath, `${JSON.stringify(manifest, null, 2)}\n`);
NODE

echo "Publishing ${PACKAGE_NAME} to GitHub Packages"
pnpm exec changeset publish
