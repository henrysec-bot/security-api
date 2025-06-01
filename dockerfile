FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    ca-certificates \
    nmap \
    whois \
    git \
    perl \
    && rm -rf /var/lib/apt/lists/*

# Clonando Nikto
RUN git clone https://github.com/sullo/nikto.git /opt/nikto

# Dando permissão no script real
RUN chmod +x /opt/nikto/program/nikto.pl

# Criando o symlink
RUN ln -s /opt/nikto/program/nikto.pl /usr/local/bin/nikto

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt
RUN chmod +x scripts/*.sh

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
