## Title for query
full query text

### Response
response.

## Set Logging Format
@general.md I want query/Response recorded like this, one ## section for each query

### Response
I will adhere to this format for all future logs: `## Title` for the query context, followed by the query text, and `### Response` for my answer.

## Fix APPSET_PATH calculation
@observability-poc/bin/setup.sh:103-104 this line is wrong, I want APPSET_PATH to be set to to the relative path within the global_config_path set in @mac-template/.envrc:3-4

### Response
I will update `observability-poc/bin/setup.sh` to ensure `APPSET_PATH` is always relative to `global_config_path`. This handles cases where `apply_and_wait` is called with an absolute path (e.g., using `${global_config_path}/...`).

## Restore Documentation History
good but you forgot to append to the docs/AI/general.md

### Response
I apologize for overwriting the file. I have restored the previous history and appended the last entry. I will ensure to read and append for all future updates.
