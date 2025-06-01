# Imagem base
FROM python:3.11-slim

# Evita prompts durante instalações
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza o sistema e instala dependências
RUN apt-get update && apt-get install -y \
    nmap \
    nikto \
    whois \
    && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
WORKDIR /app

# Copia os arquivos da API
COPY . /app

# Instala dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# Dá permissão de execução aos scripts
RUN chmod +x scripts/*.sh

# Expõe porta da API
EXPOSE 8000

# Comando para iniciar a API
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
