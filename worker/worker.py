import time
import logging
from datetime import datetime
import os

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class HeartbeatWorker:
    def __init__(self, interval: int = 30):
        self.interval = interval
        self.running = True
        
    def start(self):
        logger.info(f"Starting heartbeat worker with {self.interval}s interval")
        
        while self.running:
            try:
                self.heartbeat()
                time.sleep(self.interval)
            except KeyboardInterrupt:
                logger.info("Received interrupt signal, shutting down gracefully")
                self.running = False
            except Exception as e:
                logger.error(f"Error in worker: {e}")
                time.sleep(5)  # Brief pause before retrying
                
    def heartbeat(self):
        timestamp = datetime.now().isoformat()
        logger.info(f"💓 Heartbeat - Worker is alive at {timestamp}")
        
        # You could add additional work here, such as:
        # - Health checks on other services
        # - Database cleanup tasks
        # - Metric collection
        # - Background processing

if __name__ == "__main__":
    # Get interval from environment variable, default to 30 seconds
    interval = int(os.getenv("HEARTBEAT_INTERVAL", "30"))
    
    worker = HeartbeatWorker(interval)
    worker.start()