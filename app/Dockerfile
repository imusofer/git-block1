FROM python:3.12-slim
WORKDIR /app

COPY requirements.txt .
COPY py-block3.py .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python3", "py-block3.py"]
