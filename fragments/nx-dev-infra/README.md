# nx-dev-infra Fragment

Provides a containerized Nx development environment with supporting infrastructure.

## What's Included

- **Dockerfile.dev** - Node 22 with pnpm and Nx pre-installed
- **docker-compose.yml** - Multi-container setup:
  - `dev` - Development container with your workspace mounted
  - `db` - PostgreSQL 16 database
  - `n8n` - Workflow automation platform
- **tools/infra/project.json** - Nx targets for managing containers

## Prerequisites

- Docker Desktop installed and running
- Nx workspace (or will create one)

## Usage

### Apply to New Project

```bash
# In your project root
./.pip/bin/apply-nx-dev-infra.sh
```

### Start Infrastructure

```bash
# Start all containers
nx run infra:up

# View logs
nx run infra:logs

# Stop containers
nx run infra:down
```

### Develop in Container

```bash
# Enter dev container
docker exec -it monospace-dev bash

# Inside container
pnpm install
nx serve web
nx run api:serve
nx run mobile:start
```

## What Gets Created

```
your-project/
├── Dockerfile.dev
├── docker-compose.yml
└── tools/
    └── infra/
        └── project.json
```

## Services

### PostgreSQL (db)
- **Port**: 5432
- **Database**: nexus
- **User**: nexus
- **Password**: nexus
- **Connection**: `postgresql://nexus:nexus@localhost:5432/nexus`

### n8n (workflow automation)
- **Port**: 5678
- **URL**: http://localhost:5678
- **Auth**: Disabled for local dev
- **Database**: Uses PostgreSQL above

## Customization

After applying, you can customize:
- Container names in `docker-compose.yml`
- Database credentials
- Port mappings
- Add additional services

## Troubleshooting

### Containers won't start
```bash
# Check Docker is running
docker ps

# View container logs
docker compose logs

# Rebuild containers
docker compose up --build -d
```

### Port conflicts
Edit `docker-compose.yml` and change port mappings:
```yaml
ports:
  - "5433:5432"  # Changed from 5432:5432
```

## Next Steps

After applying this fragment, consider adding:
- **next-web** - Next.js web app scaffold
- **expo-mobile** - Expo mobile app scaffold
- **api-graphql** - GraphQL API scaffold
