from fastapi import FastAPI
from datetime import datetime
import os

app = FastAPI(
    title="AWS Starter API",
    description="A simple FastAPI backend for the AWS starter application",
    version="1.0.0"
)

@app.get("/")
async def root():
    return {
        "message": "Welcome to AWS Starter API!",
        "timestamp": datetime.now().isoformat(),
        "service": "api",
        "version": "1.0.0"
    }

@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "timestamp": datetime.now().isoformat(),
        "service": "api",
        "uptime": "running"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)