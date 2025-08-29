# Eva Box - backend
Backend do Eva Box, o seu ajudante de testes

## About
Aplicação backend em Python + FastAPI com banco de dados PostgreSQL em Docker.
Projeto em desenvolvimento para estudo e prática de APIs, autenticação e persistência de dados.


## 🚀 Tecnologias
Python 3.11+
FastAPI
SQLAlchemy
PostgreSQL (Docker)
Docker Compose


### Como rodar em modo de desenvolvimento
1. Clonar o repositório
2. Criar e ativar ambiente virtual

```bash
python -m venv venv
source venv/bin/activate
```
3. Instalar dependências
```bash
pip install -r requirements.txt
```

4. Configurar variáveis de ambiente (.env)
5. Subir banco de dados com Docker - na raiz do projeto
```bash
docker-compose up -d
```
6. Inicializar banco
```bash
docker exec -i quiz_db psql -U quizuser -d quizdb < init.sql
```
7. Testar conexão com Python
```bash
python test_db.py
```
