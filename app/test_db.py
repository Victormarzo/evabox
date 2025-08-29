from db import engine,Base,SessionLocal
from sqlalchemy import text
try:
    with engine.connect() as conn:
        result = conn.execute(text("SELECT * FROM topic;"))
        print("JOIA")
        for row in result:
            print("username:", row.name)
       
except Exception as e:
    print("Error",e)