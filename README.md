# 🚀 AWS Starter App

A multi-service containerized application template with CI/CD pipeline, perfect for getting started with microservices on AWS or any container platform.

## 🏗️ Architecture

This starter app consists of three main services:

- **Frontend**: NGINX serving a static page with API proxy
- **API**: FastAPI backend with health endpoints
- **Worker**: Python heartbeat worker service

## ✨ Features

- 🐳 **Containerized**: All services run in Docker containers
- 🔄 **CI/CD Ready**: GitHub Actions workflow for automated builds
- 📦 **Multi-Registry**: Pushes to both GitHub Container Registry and Docker Hub
- 🧪 **Testing**: Basic health checks and API tests
- 🛠️ **Development Tools**: Makefile for common operations
- 📁 **Clean Structure**: Sensible .gitignore and .dockerignore files

## 🚦 Quick Start

### Prerequisites

- Docker and Docker Compose
- Make (optional, but recommended)

### 1. Clone and Start

```bash
# Clone the repository
git clone <your-repo-url>
cd aws-starter

# Start all services
docker-compose up --build
```

### 2. Access the Application

- **Frontend**: <http://localhost:8080>
- **API**: <http://localhost:8000>
- **API Docs**: <http://localhost:8000/docs> (FastAPI auto-generated)

### 3. Using Make Commands

```bash
# See all available commands
make help

# Build all images
make build

# Start services
make compose-up

# Run tests
make test

# Stop services
make compose-down

# Clean up
make clean
```

## 🔧 Development

### Project Structure

```
aws-starter/
├── frontend/           # NGINX + Static HTML
│   ├── Dockerfile
│   ├── nginx.conf
│   └── index.html
├── api/               # FastAPI Backend
│   ├── Dockerfile
│   ├── requirements.txt
│   └── main.py
├── worker/            # Python Worker
│   ├── Dockerfile
│   ├── requirements.txt
│   └── worker.py
├── .github/workflows/ # CI/CD Pipeline
│   └── ci.yml
├── docker-compose.yml
├── Makefile
└── README.md
```

### API Endpoints

- `GET /` - Welcome message with timestamp
- `GET /health` - Health check endpoint
- `GET /docs` - Interactive API documentation

### Environment Variables

#### Worker Service

- `HEARTBEAT_INTERVAL` - Heartbeat interval in seconds (default: 30)

#### API Service

- `ENV` - Environment name (development, production)

## 🚀 Deployment

### GitHub Container Registry

```bash
# Push to GHCR (requires authentication)
make push-ghcr GITHUB_REPO=username/repo-name
```

### Docker Hub

```bash
# Push to Docker Hub (requires authentication)
make push-dhub DOCKER_USERNAME=your-username
```

### CI/CD Pipeline

The GitHub Actions workflow automatically:

1. **Builds** all service images
2. **Pushes** to GitHub Container Registry (always)
3. **Pushes** to Docker Hub (if secrets configured)
4. **Tests** the deployed services
5. **Runs** on push to main/develop and pull requests

#### Required Secrets (Optional)

For Docker Hub integration, add these GitHub secrets:

- `DOCKERHUB_USERNAME` - Your Docker Hub username
- `DOCKERHUB_TOKEN` - Your Docker Hub access token

## 🧪 Testing

### Manual Testing

```bash
# Start services
make compose-up

# Run basic tests
make test

# Check specific endpoints
curl http://localhost:8000/
curl http://localhost:8000/health
curl http://localhost:8080/
```

### Automated Testing

The CI pipeline includes:

- Service health checks
- API endpoint testing
- Worker heartbeat verification

## 📝 Customization

### Adding New Services

1. Create a new directory (e.g., `database/`)
2. Add `Dockerfile` and application code
3. Update `docker-compose.yml`
4. Add to CI workflow matrix in `.github/workflows/ci.yml`
5. Update Makefile if needed

### Modifying Services

- **Frontend**: Edit `frontend/index.html` or `frontend/nginx.conf`
- **API**: Modify `api/main.py` and update `api/requirements.txt`
- **Worker**: Update `worker/worker.py` logic

## 🐛 Troubleshooting

### Common Issues

1. **Port conflicts**: Change ports in `docker-compose.yml` if 8080/8000 are in use
2. **Permission errors**: Ensure Docker daemon is running and user has permissions
3. **Build failures**: Check Dockerfile syntax and dependencies

### Debugging

```bash
# View logs for all services
docker-compose logs

# View logs for specific service
docker-compose logs api

# Execute commands in running container
docker-compose exec api bash
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally with `make test`
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🔗 Useful Links

- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [NGINX Documentation](https://nginx.org/en/docs/)

