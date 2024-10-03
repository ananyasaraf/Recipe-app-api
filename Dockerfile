FROM python:3.9-alpine3.13
LABEL maintainer="londonappdeveloper.com"

# Set Python environment variables
ENV PYTHONUNBUFFERED=1

# Install dependencies required for venv and pip
RUN apk add --no-cache \
    build-base \
    libffi-dev \
    musl-dev \
    gcc \
    python3-dev \
    linux-headers

# Copy and install Python dependencies
COPY ./requirements.txt /temp/requirements.txt
COPY ./requirements.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app

# Set up virtual environment and install dependencies
ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /temp/requirements.txt && \
    if [ $DEV = "true"];\
        then /py/bin/pip install -r /tmp/requirements.dev.txt ;\
    fi && \
    rm -rf /temp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# Set the virtual environment in the PATH
ENV PATH="/py/bin:$PATH"

# Expose the port the app runs on
EXPOSE 8000

# Switch to non-root user
USER django-user

