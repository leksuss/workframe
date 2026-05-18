# Django App Profile

Use this profile when adapting Workframe to a Django project.

Typical extra checks:

- migrations are explicit and reviewed;
- model changes are covered by tests;
- admin/editor flows are verified when affected;
- management commands have clear dry-run or recovery behavior when risky;
- settings and secrets are not hardcoded;
- database changes are represented in OpenSpec when they affect product behavior.
