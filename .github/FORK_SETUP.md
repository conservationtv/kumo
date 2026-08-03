# Fork CI/CD setup

The fork uses three primary workflows:

- `CI` validates pull requests and pushes to `main`.
- `Release Package` manages Changesets release PRs and publishes the library to GitHub Packages.
- `Docs` builds every docs change, publishes preview versions for same-repository pull requests, and deploys `main` to Cloudflare Workers.

## GitHub Packages

The release workflow uses the repository `GITHUB_TOKEN`; an npm token is not required. It stages the package under the repository owner scope, so this repository publishes `@conservationtv/kumo` while the source workspace keeps its upstream-compatible `@cloudflare/kumo` name.

The repository can keep the default **Read repository contents and packages permissions** setting. Each workflow declares its required permissions explicitly.

The Changesets workflow does require **Allow GitHub Actions to create and approve pull requests** under **Settings → Actions → General**. If that setting is inherited or disabled, an organization owner must enable it under **Organization Settings → Actions → General**. An enterprise policy may also lock the organization setting.

Consumers need this in their project `.npmrc`:

```ini
@conservationtv:registry=https://npm.pkg.github.com
```

Private packages also require a GitHub token with `read:packages`. Package visibility and repository access are managed from the package settings after its first publish.

## Cloudflare Workers

Create these repository settings under **Settings → Secrets and variables → Actions**:

| Type     | Name                     | Value                                                                              |
| -------- | ------------------------ | ---------------------------------------------------------------------------------- |
| Secret   | `CLOUDFLARE_API_TOKEN`   | Cloudflare API token with Workers Scripts edit and Workers Routes edit permissions |
| Secret   | `CLOUDFLARE_ACCOUNT_ID`  | Cloudflare account ID                                                              |
| Variable | `CLOUDFLARE_WORKER_NAME` | Worker name, for example `kumo-docs`                                               |
| Variable | `DOCS_DOMAIN`            | Optional bare production hostname override; defaults to `ui.docs.conservation.tv`  |

The `conservation.tv` zone must belong to the configured Cloudflare account. The production workflow configures `ui.docs.conservation.tv` as the Worker's Custom Domain unless `DOCS_DOMAIN` overrides it. Cloudflare creates the DNS record and certificate automatically.

Enable preview URLs for the Worker in **Workers & Pages → your Worker → Settings → Domains & Routes**. Pull requests from branches in this repository then receive a version-specific `workers.dev` preview URL. Fork pull requests are built and tested but are not deployed because GitHub does not expose deployment secrets to them.

Run the `Docs` workflow manually once, or push a docs change to `main`, to create the Worker before expecting pull-request previews.

## Repository cleanup

Deleting workflow files does not remove required status checks from branch protection. In **Settings → Branches** or repository rulesets, remove old checks such as `Bonk Check`, `Reviewer`, and PR-description validation, then require `CI / validate` if desired.
