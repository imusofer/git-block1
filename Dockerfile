FROM python:3.12-slim

WORKDIR /app

COPY scripts/py-block2.py scripts/

COPY data/statuses.txt data/

CMD ["python3", "scripts/py-block2.py"]






