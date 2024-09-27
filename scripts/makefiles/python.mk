# Define the locations to check
LOCATIONS := src/

.PHONY: ruff black isort pylint mypy lint-all format check test check-all
.PHONY: black-fix isort-fix ruff-fix fix-all

ruff:
	uv run ruff check $(LOCATIONS)

black:
	uv run black --check $(LOCATIONS)

isort:
	uv run isort --check-only $(LOCATIONS)

pylint:
	uv run pylint $(LOCATIONS)

mypy:
	uv run mypy $(LOCATIONS)

lint-all: ruff black isort pylint mypy

format: isort-fix black-fix

check: format lint-all

test:
	uv run pytest tests/

.SILENT: install-uv
install-uv:
	if command -v uv >/dev/null 2>&1; then \
		echo "uv binary already exists"; \
	else \
		curl -LsSf https://astral.sh/uv/install.sh | sh; \
		source ${HOME}/.cargo/env; \
	fi

check-all: check test

# Fix targets
black-fix:
	uv run black $(LOCATIONS)

isort-fix:
	uv run isort $(LOCATIONS)

ruff-fix:
	uv run ruff --fix $(LOCATIONS)

fix-all: isort-fix black-fix ruff-fix