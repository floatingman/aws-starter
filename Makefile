.PHONY: help build compose-up compose-down push-ghcr push-dhub clean test

# Default target
help:
	@echo "AWS Starter App - Available commands:"
	@echo "  build        - Build all Docker images"
	@echo "  compose-up   - Start all services with docker-compose"
	@echo "  compose-down - Stop all services and remove containers"
	@echo "  push-ghcr    - Push images to GitHub Container Registry"
	@echo "  push-dhub    - Push images to Docker Hub"
	@echo "  test         - Run basic tests against local services"
	@echo "  clean        - Clean up Docker images and containers"

# Build all Docker images
build:
	@echo "Building all services..."
	docker-compose build

# Start services
compose-up:
	@echo "Starting services..."
	docker-compose up -d
	@echo "Services started!"
	@echo "Frontend: http://localhost:8080"
	@echo "API: http://localhost:8000"

# Stop services
compose-down:
	@echo "Stopping services..."
	docker-compose down -v

# Push to GitHub Container Registry
push-ghcr:
	@echo "Pushing to GitHub Container Registry..."
	@if [ -z "$(GITHUB_REPO)" ]; then \
		echo "Error: GITHUB_REPO environment variable not set"; \
		echo "Usage: make push-ghcr GITHUB_REPO=username/repo-name"; \
		exit 1; \
	fi
	docker tag aws-starter_frontend ghcr.io/$(GITHUB_REPO)/frontend:latest
	docker tag aws-starter_api ghcr.io/$(GITHUB_REPO)/api:latest
	docker tag aws-starter_worker ghcr.io/$(GITHUB_REPO)/worker:latest
	docker push ghcr.io/$(GITHUB_REPO)/frontend:latest
	docker push ghcr.io/$(GITHUB_REPO)/api:latest
	docker push ghcr.io/$(GITHUB_REPO)/worker:latest

# Push to Docker Hub
push-dhub:
	@echo "Pushing to Docker Hub..."
	@if [ -z "$(DOCKER_USERNAME)" ]; then \
		echo "Error: DOCKER_USERNAME environment variable not set"; \
		echo "Usage: make push-dhub DOCKER_USERNAME=your-username"; \
		exit 1; \
	fi
	docker tag aws-starter_frontend $(DOCKER_USERNAME)/aws-starter-frontend:latest
	docker tag aws-starter_api $(DOCKER_USERNAME)/aws-starter-api:latest
	docker tag aws-starter_worker $(DOCKER_USERNAME)/aws-starter-worker:latest
	docker push $(DOCKER_USERNAME)/aws-starter-frontend:latest
	docker push $(DOCKER_USERNAME)/aws-starter-api:latest
	docker push $(DOCKER_USERNAME)/aws-starter-worker:latest

# Run basic tests
test:
	@echo "Running tests..."
	@echo "Testing API endpoints..."
	curl -f http://localhost:8000/ > /dev/null || (echo "API root endpoint failed" && exit 1)
	curl -f http://localhost:8000/health > /dev/null || (echo "API health endpoint failed" && exit 1)
	@echo "Testing frontend..."
	curl -f http://localhost:8080/ > /dev/null || (echo "Frontend failed" && exit 1)
	curl -f http://localhost:8080/api/ > /dev/null || (echo "Frontend API proxy failed" && exit 1)
	@echo "All tests passed!"

# Clean up
clean:
	@echo "Cleaning up..."
	docker-compose down -v --remove-orphans
	docker system prune -f
	@echo "Cleanup complete!"