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

# Expose port if needed (though MCP typically uses stdio)
EXPOSE 8000

# Run the MCP server using uvx mcpo
CMD ["uvx", "mcpo", "--config", "config.json"]
