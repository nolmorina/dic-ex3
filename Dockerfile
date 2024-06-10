FROM python:3.11-slim

# Install required system packages
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . /app
WORKDIR /app

# Set environment variables to suppress TensorFlow GPU warnings
ENV TF_CPP_MIN_LOG_LEVEL=2
ENV CUDA_VISIBLE_DEVICES=""

# Expose the application port
EXPOSE 80

# Run the application
CMD ["python", "app.py"]
