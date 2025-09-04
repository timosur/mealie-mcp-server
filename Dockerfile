# Use Python 3.12 slim image as base
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Copy project files
COPY pyproject.toml uv.lock ./
COPY src/ ./src/

# Install dependencies
RUN uv sync --frozen

# Set environment variables for the MCP server
ENV PYTHONPATH=/app/src
ENV LOG_LEVEL=INFO

# Expose port for the MCP server
EXPOSE 8000

# Environment variables to be set at runtime
# MEALIE_BASE_URL - Base URL for Mealie instance
# MEALIE_API_KEY - API key for Mealie authentication  
# API_KEY - API key for MCP server authentication

# Run the MCP server using uvx mcpo with port and API key
CMD ["sh", "-c", "uvx mcpo --port 8000 --api-key $API_KEY -- uv --directory src run server.py"]
