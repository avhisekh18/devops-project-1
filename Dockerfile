# ── Stage 1: Build & Test ──────────────────────────
FROM python:3.12-slim AS builder

WORKDIR /app

# Install dependencies first (better caching)
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY app/ .

# Run tests — if they fail, build stops here
RUN pytest test_app.py -v

# ── Stage 2: Production Image ───────────────────────
FROM python:3.12-slim AS production

# Security: run as non-root user
RUN addgroup --system appgroup && \
    adduser --system --ingroup appgroup appuser

WORKDIR /app

# Copy only what we need from Stage 1
COPY --from=builder /usr/local/lib/python3.12/site-packages \
     /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin/gunicorn /usr/local/bin/gunicorn
COPY app/app.py .

# Switch to non-root user
USER appuser

EXPOSE 5000

# Health check — Docker will ping this every 30s
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD python -c \
    "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')"

# Start app with gunicorn (production server)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "app:app"]


# **Key lines explained:**
# - `FROM python:3.12-slim` — start from an official Python image (slim = smaller size)
# - `WORKDIR /app` — all commands run inside this folder in the container
# - `COPY app/requirements.txt .` — copy requirements into container
# - `RUN pip install...` — install packages inside the container
# - `RUN pytest test_app.py -v` — run tests; if they fail, Docker stops building
# - `USER appuser` — run as non-root for security (most beginners miss this!)
# - `EXPOSE 5000` — tell Docker the app listens on port 5000
# - `CMD [...]` — the command that starts your app when container launches


