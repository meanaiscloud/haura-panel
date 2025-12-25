# Haura Panel

This repository bootstraps a **real** Haura Panel by pulling the official Pterodactyl sources (Laravel/PHP backend, React frontend, and the Go-based Wings daemon) and applying Haura branding. The included bootstrap script clones upstream repos—no mock services or placeholder code—and prepares them for customization.

## Current status

- No upstream sources are vendored yet; use the import script below to unpack an official release archive (or the bootstrap script when network access is available).
- Repository contains automation to clone or import the Pterodactyl panel and wings codebases into this tree.
- Rebranding steps are automated where safe (e.g., default app name), with further tweaks called out for follow-up.

## Quick start: fetch and rebrand (no internet in CI)

Network egress is restricted in this environment, so the repo cannot fetch upstream sources automatically. Use one of the following offline-friendly options to pull in the real Pterodactyl code and apply the Haura defaults.

### Option A: one-shot import (archives or git bundles)

Run a single command to pull both the panel and wings using local artifacts (no
network needed):

```bash
# archives downloaded from the official GitHub releases pages
./scripts/import-haura-all.sh --panel-archive ./panel.tar.gz --wings-archive ./wings.tar.gz

# OR git bundles exported from networked machines to preserve commit history
./scripts/import-haura-all.sh --panel-bundle ./panel.bundle --wings-bundle ./wings.bundle

# OR fetch tarballs directly when outbound network access works
./scripts/import-haura-all.sh --fetch-tarballs --panel-ref develop --wings-ref master
```

The script:

1. Imports both codebases into `panel/` and `wings/` in one pass.
2. Sets the default Laravel app name to **Haura Panel** in `.env.example` and
   `config/app.php`.
3. Skips work if either directory already exists.
4. Accepts `--allow-git-clone` to pull directly from GitHub when outbound access
   is permitted.
5. Accepts `--fetch-tarballs` to download upstream tarballs automatically when
   network access is available (defaults to panel `develop` and wings `master`
   refs; override with `--panel-ref` / `--wings-ref`).

### Option B: import panel only from release archives (fastest)

1. Download the official Pterodactyl **panel** release archive (`panel.tar.gz`) from <https://github.com/pterodactyl/panel/releases> on a machine with internet access.
2. Move the archive into this repository (e.g., `./panel.tar.gz`).
3. Run the import script to unpack and apply the Haura defaults:

```bash
./scripts/import-panel-from-archive.sh ./panel.tar.gz
```

What the script does:

1. Extracts the upstream panel code into `panel/`.
2. Sets the default Laravel app name in `panel/.env.example` to **Haura Panel** and updates `config/app.php` to match.

### Option C: import full git history via bundles (preserves commits)

1. On a networked machine, export git bundles:

```bash
git clone https://github.com/pterodactyl/panel.git && cd panel
git bundle create ../panel.bundle --all
cd ..
git clone https://github.com/pterodactyl/wings.git && cd wings
git bundle create ../wings.bundle --all
```

2. Copy `panel.bundle` (and optionally `wings.bundle`) into this repository.
3. Import the bundles locally:

```bash
./scripts/import-from-bundles.sh ./panel.bundle ./wings.bundle
```

What the script does:

1. Clones the bundles into `panel/` and `wings/`, preserving git history.
2. Applies Haura defaults to the Laravel `.env.example` and `config/app.php` files.
3. Leaves remotes untouched so you can add your own origin for Haura-hosted forks.

After bootstrapping:

- Follow the official Pterodactyl installation docs inside `panel/` and `wings/`, substituting Haura branding where appropriate.
- Update branding assets (logos, titles, env defaults, Docker image names) across the panel and daemon to complete the rebrand.
- Replace documentation references with Haura naming and URLs.

## Platform targets

Once the upstream code is present, ensure the installer scripts and docs cover:

- **Ubuntu 22.04+**, **Debian 11+**, **CentOS Stream 8+**: package prerequisites, PHP extensions, MySQL/MariaDB setup, Docker, and Wings systemd units.
- **Windows (local development)**: WSL2 or Docker Desktop for backend services, Node/Yarn for the React frontend, and Go toolchain for Wings.

## Advanced feature catalog

The Haura Panel design targets more than 30 advanced capabilities across orchestration, security, observability, and operations. Each feature is documented separately for clarity and implementation tracking:

- [Distributed fleet orchestration](docs/features/01-distributed-fleet-orchestration.md)
- [GPU-aware scheduling](docs/features/02-gpu-aware-scheduling.md)
- [Spot capacity and cost optimizer](docs/features/03-spot-cost-optimizer.md)
- [Advanced deployment strategies](docs/features/04-deployment-strategies.md)
- [Zero-trust SSO and RBAC](docs/features/05-zero-trust-sso.md)
- [Compliance-grade auditing](docs/features/06-compliance-auditing.md)
- [Tenant isolation and quotas](docs/features/07-tenant-isolation.md)
- [Ephemeral developer environments](docs/features/08-ephemeral-dev-environments.md)
- [SLO-driven autoscaling](docs/features/09-autoscaling-slo-driven.md)
- [WAF and DoS protection](docs/features/10-waf-and-dos-protection.md)
- [Backup and disaster recovery](docs/features/11-backup-and-dr.md)
- [Full-stack observability](docs/features/12-observability-stack.md)
- [Event bus and webhooks](docs/features/13-event-bus-and-webhooks.md)
- [CLI and API gateway](docs/features/14-cli-and-api-gateway.md)
- [Marketplace and templates](docs/features/15-marketplace-and-templates.md)
- [Billing and metering](docs/features/16-billing-and-metering.md)
- [Policy-as-code guardrails](docs/features/17-policy-as-code.md)
- [Secret management](docs/features/18-secret-management.md)
- [Data pipelines and storage](docs/features/19-data-pipelines-and-storage.md)
- [Network microsegmentation](docs/features/20-network-microsegmentation.md)
- [Plugin and extension SDK](docs/features/21-plugin-sdk.md)
- [Analytics and reporting](docs/features/22-analytics-and-reporting.md)
- [Self-service support portal](docs/features/23-self-service-support.md)
- [Accessibility and localization](docs/features/24-accessibility-and-localization.md)
- [Migration toolkit](docs/features/25-migration-toolkit.md)
- [HA clustering and failover](docs/features/26-ha-cluster-failover.md)
- [Mod and asset management](docs/features/27-mod-and-asset-management.md)
- [Container security](docs/features/28-container-security.md)
- [Data residency and sovereignty](docs/features/29-data-residency.md)
- [Registry mirroring and caching](docs/features/30-registry-mirroring.md)
- [Offline and air-gapped operations](docs/features/31-offline-and-airgapped.md)
- [Latency optimization and routing](docs/features/32-latency-optimization.md)

## Next steps for an advanced Haura Panel

- Add automated installers for each target OS, including database bootstrap and Docker runtime validation.
- Harden the stack with TLS by default, audit logging, and monitoring hooks.
- Extend multi-node scheduling, backups, metrics, and API rate limiting to meet the "super advanced" requirement.
- Build a CI/CD pipeline to lint/test the Laravel backend, React frontend, and Go daemon on every change.
