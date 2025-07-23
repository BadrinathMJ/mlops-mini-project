#Stage 1
FROM python:3.10 AS build

WORKDIR /app

#Copy the requirements.txt file from flask_app folder
COPY flask_app/requirements.txt /app/

#Install Dependencies
RUN pip install --no-cache-dir -r requirements.txt

#Copy application code and model files
COPY flask_app/ /app/
COPY models/vectorizer.pkl /app/models/vectorizer.pkl

#DOWNLOAD ONLy the necessary NLTK data
RUN python -m nltk.downloader stopwords wordnet

#Stage 2
FROM python:3.10-slim AS final

WORKDIR /app

#Copy the necessary files from build stage
COPY --from=build /app /app

#Expose the application port
EXPOSE 5000

#Set the command to run the applictaion
CMD ["gunicorn", "--bind", "0.0.0.0:5000","--timeout", "120","app:app"]






# FROM python:3.10-slim

# WORKDIR /app

# COPY flask_app/ /app/

# COPY models/vectorizer.pkl /app/models/vectorizer.pkl

# RUN pip install -r requirements.txt

# RUN python -m nltk.downloader stopwords wordnet

# EXPOSE 5000

# CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--timeout", "120", "app:app"]