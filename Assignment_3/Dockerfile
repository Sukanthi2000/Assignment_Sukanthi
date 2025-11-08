# Use Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy dependencies
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY . .

# Expose app port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
