from flask import Flask, render_template, request
import mlflow
from preprocessing_utility import normalize_text
app  = Flask(__name__)
import dagshub
import pickle
mlflow.set_tracking_uri('https://dagshub.com/mjcode14/mlops-mini-project.mlflow')
dagshub.init(repo_owner='mjcode14', repo_name='mlops-mini-project', mlflow=True)
# load model from model registry
def get_latest_model_version(model_name):
    client = mlflow.MlflowClient()
    latest_version = client.get_latest_versions(model_name, stages=["Production"])
    if not latest_version:
        latest_version = client.get_latest_versions(model_name, stages=["None"])
    return latest_version[0].version if latest_version else None
model_name = "my_model"
model_version = get_latest_model_version(model_name)

model_uri = f'models:/{model_name}/{model_version}'
vectorizer = pickle.load(open('models/vectorizer.pkl', 'rb'))

model = mlflow.pyfunc.load_model(model_uri)

@app.route('/')
def home():
    return render_template('index.html')



@app.route('/predict', methods=['POST'])
def predict():
    text = request.form['text']

    #Load model from model registry

    #clean
    text = normalize_text(text)
    #bow
    features = vectorizer.transform([text])

    result = model.predict(features)
    # show
    return render_template('index.html', result=result[0])

if __name__ == "__main__":
    app.run(debug=True)