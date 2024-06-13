# Database Migration for CVE Processor Application

This repository contains the database migration scripts and configuration for the CVE Processor application.

## Prerequisites

- Docker
- Jenkins

## Usage

The database migration is automatically run as part of the CVE Processor application deployment using an init container.

## Flyway Configuration

The Flyway configuration is stored in the `conf/flyway.conf` file. It includes the following properties:

- `flyway.url`: JDBC URL for the database connection
- `flyway.user`: Username for the database connection
- `flyway.password`: Password for the database connection
- `flyway.schemas`: Comma-separated list of schemas to manage

The actual values for these properties are provided through environment variables during the application deployment.

## Migration Scripts

The migration scripts are located in the `sql` directory. They follow the naming convention `V<version>__<description>.sql` and are executed in version order by Flyway.

Example:
- `V0__create_table.sql`: Creates the initial `cve` table.

## Continuous Integration

The repository includes Jenkins pipeline files for continuous integration:

- `Jenkinsfile`: Defines the CI pipeline for pull requests. It includes the following stages:
  - Checkout: Checks out the pull request branch.
  - Fetch Base Branch: Fetches the base branch from the original repository.
  - Create Commitlint Config: Creates the commitlint configuration file.
  - Check Conventional Commits: Verifies that the commit messages follow the Conventional Commits specification.

- `Jenkinsfile2`: Defines the CI/CD pipeline for the main branch. It includes the following stages:
  - Checkout: Checks out the main branch.
  - Determine Version: Determines the next version number based on the commit messages.
  - Setup Docker and Build: Builds and pushes the Docker image for multiple platforms.
  - Tag and Push Version: Tags the repository with the new version and pushes the tag.

## Docker Image

The database migration is packaged as a Docker image based on the `flyway/flyway` image. The `Dockerfile` copies the Flyway configuration and migration scripts into the image.

The Docker image is built and pushed to Docker Hub using the `Jenkinsfile2` pipeline.

## Version Determination

The `get_next_version.sh` script is used to determine the next version number based on the commit messages. It follows the Semantic Versioning specification and increments the version accordingly:
- If the commit message includes `BREAKING CHANGE`, it increments the major version.
- If the commit message includes `feat`, it increments the minor version.
- Otherwise, it increments the patch version.

## Contributing

To contribute to this repository, please follow the guidelines below:

1. Fork the repository and create a new branch for your changes.
2. Make your changes and commit them with descriptive messages following the Conventional Commits specification.
3. Push your changes to your forked repository.
4. Open a pull request to the main repository.

Please ensure that your pull request passes all the status checks before merging.
