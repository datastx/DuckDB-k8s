FROM python:3.9-slim

RUN pip install duckdb

WORKDIR /app

COPY src/query_duckdb.py .

CMD ["python", "query_duckdb.py"]