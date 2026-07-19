FROM php:8.2-cli-alpine

# Pull latest patched packages within this Alpine release - fixes known
# CVEs in bundled OS libraries (e.g. c-ares) without waiting for a new
# base image tag. Real production practice: rebuild periodically even
# with no code changes, since base image CVEs get discovered over time.
RUN apk update && apk upgrade --no-cache

RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/api
COPY src/ /var/www/api/

RUN addgroup -g 1000 appuser && adduser -u 1000 -G appuser -s /bin/sh -D appuser \
    && chown -R appuser:appuser /var/www/api
USER appuser

EXPOSE 8080

# Basic healthcheck - real pipelines gate deploys on this passing
HEALTHCHECK --interval=30s --timeout=3s CMD php -r "echo file_get_contents('http://localhost:8080/health');" || exit 1

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/api"]

