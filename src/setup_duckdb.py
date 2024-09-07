import os

import duckdb

db_path = ".database/my_db.duckdb"


def setup_database() -> None:
    """ """
    os.makedirs(os.path.dirname(db_path), exist_ok=True)

    if os.path.exists(db_path):
        os.remove(db_path)
        print("Removed existing database file.")

    conn = duckdb.connect(db_path)

    try:
        conn.execute(
            """
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY,
                name VARCHAR(100),
                email VARCHAR(100)
            )
        """
        )

        conn.execute(
            """
            CREATE TABLE IF NOT EXISTS orders (
                id INTEGER PRIMARY KEY,
                user_id INTEGER,
                product VARCHAR(100),
                quantity INTEGER,
                FOREIGN KEY (user_id) REFERENCES users(id)
            )
        """
        )

        conn.execute(
            """
            INSERT INTO users (id, name, email) VALUES
            (1, 'Alice', 'alice@example.com'),
            (2, 'Bob', 'bob@example.com'),
            (3, 'Charlie', 'charlie@example.com')
        """
        )

        conn.execute(
            """
            INSERT INTO orders (id, user_id, product, quantity) VALUES
            (1, 1, 'Widget', 5),
            (2, 1, 'Gadget', 2),
            (3, 2, 'Doodad', 3),
            (4, 3, 'Widget', 1)
        """
        )

        print("Database setup completed successfully.")

        print("\nUsers:")
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
    setup_database()
