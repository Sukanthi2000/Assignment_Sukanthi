
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py /app/

EXPOSE 5000

# Use gunicorn for production-like serving
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]

WORKDIR /app
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py /app/

EXPOSE 5000

# Use gunicorn for production-like serving
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
