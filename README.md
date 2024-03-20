# Advanced Slime Downloader

This script allows you to download files from the Infernal Suite API based on Minecraft versions and projects.

## Pterodactyl Egg

Pterodactyl Egg is now available!

[egg-advanced-slime.json](egg-advanced-slime.json)

## Usage

```bash
./AdvancedSlimeDownloader.sh <mcVersion> <project> <branchName>
```

- `mcVersion`: Minecraft version (e.g., 1.20.4)
- `project`: Project name (e.g., asp, aspufferfish, aspurpur)
- `branchName`: Branch name (Check [here][branchApi] for available branches)

## Prerequisites

- Bash shell
- curl
- jq

## Installation

1. Clone this repository:

    ```bash
    git clone https://github.com/HappyAreaBean/AdvancedSlimeDownloader.git
    ```

2. Make the script executable:

    ```bash
    chmod +x AdvancedSlimeDownloader.sh
    ```

Or use curl

```bash
curl -O https://raw.githubusercontent.com/HappyAreaBean/AdvancedSlimeDownloader/main/AdvancedSlimeDownloader.sh && chmod +x ./AdvancedSlimeDownloader.sh
```

## Usage Example

```bash
./AdvancedSlimeDownloader.sh 1.20.4 aspurpur purpur_upstream
```

## Description

- The script retrieves JSON data from the Infernal Suite API based on the provided Minecraft version and project.
- It parses the JSON data and constructs download links for the files.
- It downloads the files using `curl`.

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

[branchApi]: https://api.infernalsuite.com/swagger/index.html#operations-DynamicProject-get_v1_projects__projectSlug__mcversion__version__branches
