# Database Migration for CVELens Processor Application

This repository contains the database migration scripts and configuration for the CVELens Processor application.

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

## CI/CD Workflow Overview
### GitHub -> Jenkins Integration
- GitHub Webhook: A webhook is configured on this repository to trigger Jenkins jobs on specific GitHub events (e.g., pull requests).
- Jenkins Pipelines: There are two Jenkins pipelines (Jenkinsfile1 and Jenkinsfile2) that handle validation, building, tagging, and publishing multi-architecture Docker images supporting ARM64 and AMD64 platforms.

### CI/CD Pipeline Flow
#### Code Validation and Linting (Jenkinsfile1)

- Trigger: Pull requests to the main branch
- This pipeline performs several checks to ensure that the commit messages adhere to the Conventional Commits standard before allowing a merge.

#### Helm Chart Publishing (Jenkinsfile2)
- Trigger: Merging a pull request into the main branch
- Once the code passes all validations, and a pull request is merged, this pipeline automatically versions, tags and publishes the Docker image to DockerHub Registry.

## Version Determination

The `get_next_version.sh` script is used to determine the next version number based on the commit messages. It follows the Semantic Versioning specification and increments the version accordingly:
- If the commit message includes `BREAKING CHANGE`, it increments the major version.
- If the commit message includes `feat`, it increments the minor version.
- Otherwise, it increments the patch version.