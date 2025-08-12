FROM python:3.11-slim

WORKDIR /app

# Copy requirements (even if empty, for consistency)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY worker.py .

# Set default environment variables
ENV HEARTBEAT_INTERVAL=30

CMD ["python", "worker.py"]