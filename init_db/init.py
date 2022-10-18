import psycopg2
from psycopg2 import Error
import datetime

try:
    # Подключаемся к существующей базе данных
    connection = psycopg2.connect(user="dwh_voronezh",
                                  password="dwh_voronezh_qhi8P4t4",
                                  host="de-edu-db.chronosavant.ru",
                                  port="5432",
                                  database="dwh"
                                  )

    print("Соединение установлено")

    # Запускаем скрипт создания таблиц
    cursor = connection.cursor()
    cursor.execute(open("init.sql", "r").read())

except (Exception, Error) as error:
    print("Ошибка при работе с PostgreSQL", error)
finally:
    if connection:
        connection.commit()
        cursor.close()
        connection.close()
        print(f"Соединение с PostgreSQL закрыто {datetime.datetime.now().time()}")
