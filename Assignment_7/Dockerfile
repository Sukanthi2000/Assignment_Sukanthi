# Use official Python 3.11 image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY buggy_app.py .

# Expose port
EXPOSE 5000

# Start the app
CMD ["python", "buggy_app.py"]
