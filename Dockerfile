# Stage 1: Build the application
# Use an official Python runtime as a parent image.
# 'slim' is a good choice for a smaller image size.
FROM python:3.11-slim as builder

# Set the working directory in the container
WORKDIR /app

# Install poetry for dependency management
RUN pip install --no-cache-dir --upgrade pip

# Copy dependency file and install dependencies
# This is done first to leverage Docker's layer caching.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's code
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
# Use 0.0.0.0 to make it accessible from outside the container
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]