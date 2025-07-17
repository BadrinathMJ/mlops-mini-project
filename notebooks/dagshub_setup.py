import dagshub

import mlflow
dagshub.init(repo_owner='mjcode14', repo_name='mlops-mini-project', mlflow=True)

mlflow.set_tracking_uri('https://dagshub.com/mjcode14/mlops-mini-project.mlflow')

with mlflow.start_run():
  mlflow.log_param('parameter name', 'value')
  mlflow.log_metric('metric name', 1)