from fastapi import FastAPI
app = FastAPI(title='Sistema')

@app.get("/")
def root():
    return{"message":"E V A  B O X"}