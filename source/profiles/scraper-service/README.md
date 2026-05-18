# Scraper Service Profile

Use this profile when adapting Workframe to a scraping or ingestion service.

Typical extra checks:

- source permissions, robots policies, and request limits are considered;
- retries, timeouts, backoff, and partial failure behavior are explicit;
- parsing assumptions are tested with fixtures;
- deduplication and idempotency are defined;
- observability and recovery workflows are documented;
- schema or output contract changes go through OpenSpec.
