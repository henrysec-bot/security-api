from fastapi import FastAPI, HTTPException, Request
import subprocess
import os
import re

app = FastAPI()

API_TOKEN = os.getenv("f6c5b46e8a9e7084bc8e510aab254473")

@app.get("/")
async def root():
    return {"message": "API Henry Security está ativa!"}

@app.post("/analise_rapida")
async def analise_rapida(request: Request):
    headers = request.headers
    if headers.get("Authorization") != f"Bearer {API_TOKEN}":
        raise HTTPException(status_code=403, detail="Unauthorized")

    data = await request.json()
    url = data.get("url")
    if not url:
        raise HTTPException(status_code=400, detail="URL is required")

    # Limpa http:// e https://
    clean_url = re.sub(r'^https?:\/\/', '', url)

    cmd = f"./scripts/analise_rapida.sh {clean_url}"
    process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()

    if stderr:
        return {"error": stderr.decode()}

    return {"relatorio": stdout.decode()}
