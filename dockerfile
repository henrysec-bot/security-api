FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

# Instalando dependências do sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    ca-certificates \
    nmap \
    whois \
    git \
    perl \
    traceroute \
    whatweb \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Clonando Nikto
RUN git clone https://github.com/sullo/nikto.git /opt/nikto

# Dando permissão no script real
RUN chmod +x /opt/nikto/program/nikto.pl

# Criando o symlink pra usar o comando 'nikto' diretamente
RUN ln -s /opt/nikto/program/nikto.pl /usr/local/bin/nikto

WORKDIR /app

COPY . /app

# Instalando dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# Garantindo permissão pros scripts shell
RUN chmod +x scripts/*.sh

RUN apt-get update && apt-get install -y iputils-ping nmap whois curl


EXPOSE 8000

# Comando padrão pra iniciar a API
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
