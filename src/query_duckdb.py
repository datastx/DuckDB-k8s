import os

import duckdb

db_path = "/data/my_db.duckdb"


def query_database() -> None:
    """
    Query the DuckDB database and print the results.
    """

    if not os.path.exists(db_path):
        print(f"Database file not found at {db_path}")
        return

    conn = duckdb.connect(db_path)

    try:
        print("Users:")
        result = conn.execute("SELECT * FROM users").fetchall()
        for row in result:
            print(row)

        print("\nOrders:")
        result = conn.execute("SELECT * FROM orders").fetchall()
        for row in result:
            print(row)

    except Exception as e:
        print(f"An error occurred: {e}")

    finally:
        conn.close()


if __name__ == "__main__":
    query_database()
