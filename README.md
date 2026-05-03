# renovate

My self-hosted Renovate instance and shared presets

## Test Renovate Against a Local Repository

### Ways to Run Renovate

- Nix: `nix run github:bigolu/renovate`
- Docker: `docker run -it --platform linux/amd64 -v $(pwd):/workdir ghcr.io/lix-project/lix:latest /bin/sh -c 'cd workdir && nix run github:bigolu/renovate'`

### Environment Variables

- `RENOVATE_TOKEN` and `RENOVATE_GITHUB_COM_TOKEN`: Access token
- [`RENOVATE_ADDITIONAL_CONFIG_FILE`][renovate-additional-config-file]: Use this to extend the global config

## Adding another repository

1. If you're a new user:
   1. Install the [bigolu-renovate][bigolu-renovate] app.
   2. Add yourself to the [workflow matrix](.github/workflows/renovate.yaml).
2. Go to your [bigolu-renovate][bigolu-renovate] app installation settings and ensure the app has permission to access the new repository.
3. Add the repository to the [workflow matrix](.github/workflows/renovate.yaml).

[renovate-additional-config-file]: https://docs.renovatebot.com/config-overview/#additional-file-config
[bigolu-renovate]: https://github.com/apps/bigolu-renovate