FROM python:3.9-slim
WORKDIR /home
COPY requirements.txt .
COPY homework8.py .
RUN mkdir -p /home/input
RUN mkdir -p /home/output
RUN pip install --no-cache-dir -r requirements.txt
USER root
CMD ["python", "homework8.py"]