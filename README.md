# Kumo

A fork of Cloudflare's component library for building modern web applications.

Kumo provides accessible, design-system-compliant UI components built on [Base UI](https://base-ui.com/). It handles keyboard navigation, focus management, and ARIA attributes so you can build accessible applications without thinking through every detail.

<img width="2560" height="1456" alt="image" src="https://github.com/user-attachments/assets/032f5a0e-b686-4440-b1ca-6182379479aa" />

## Installation

```bash
echo "@conservationtv:registry=https://npm.pkg.github.com" >> .npmrc
pnpm add @conservationtv/kumo
```

### Peer Dependencies

```bash
pnpm add react react-dom @phosphor-icons/react
```

## Usage

```tsx
import { Button, Input, Dialog } from "@conservationtv/kumo";
import "@conservationtv/kumo/styles";
```

### Granular Imports (Tree-Shaking)

```tsx
import { Button } from "@conservationtv/kumo/components/button";
```

### Base UI Primitives

Kumo re-exports all Base UI primitives for advanced use cases:

```tsx
import { Popover } from "@conservationtv/kumo/primitives/popover";
```

## CLI

Query component documentation from the command line:

```bash
npx @conservationtv/kumo ls          # List all components
npx @conservationtv/kumo doc Button  # Get component docs
npx @conservationtv/kumo docs        # Get all docs
```

## Development

See [AGENTS.md](./AGENTS.md) for comprehensive development documentation including:

- Component patterns and styling system
- Semantic color tokens
- Development workflows
- CI/CD pipeline
- Figma plugin

### Quick Start

```bash
pnpm install
pnpm dev                    # Start docs site at localhost:4321
pnpm --filter @cloudflare/kumo test
```

### Figma Plugin

```bash
# Optional: enable token sync during build
# cp packages/kumo-figma/scripts/.env.example packages/kumo-figma/scripts/.env
# $EDITOR packages/kumo-figma/scripts/.env  # set FIGMA_TOKEN (and optionally FIGMA_FILE_KEY)

pnpm --filter @cloudflare/kumo-figma build
# In Figma: Plugins > Development > Import plugin from manifest...
# Select: packages/kumo-figma/src/manifest.json
```

### Creating Components

```bash
pnpm --filter @cloudflare/kumo new-component
```

## Documentation

- **Live Docs**: [ui.docs.conservation.tv](https://ui.docs.conservation.tv)
- **Fork deployment**: See [`.github/FORK_SETUP.md`](./.github/FORK_SETUP.md)
- **AI/Agent Guide**: [AGENTS.md](./AGENTS.md)

## License

MIT
