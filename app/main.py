import uvicorn
from fastapi import FastAPI, Request
from openai_service import chat

app = FastAPI()


@app.post("/")
async def message(request: Request):
    res = await request.json()
    return chat(res["message"])

if __name__ == "__main__":
   uvicorn.run(app, host="0.0.0.0", port=9000)