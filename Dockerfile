FROM python:3.11.1-slim

WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    libpq-dev \
    git \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install dependencies
RUN pip install --upgrade pip setuptools wheel

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose the application port
EXPOSE 8080

# Start the FastAPI app with hot-reload
CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "8080"]




# # pull the official docker image
# FROM python:3.11.1-slim

# # set work directory
# WORKDIR /app

# # set env variables
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1

# # install dependencies
# COPY requirements.txt .
# RUN pip install -r requirements.txt

# # copy project
# COPY . .
