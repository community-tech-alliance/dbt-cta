import json
import pandas as pd
from google.cloud import bigquery

def is_valid_bigquery_type(value, data_type, project_id):
  """Checks if the timestamp string matches the BigQuery timestamp regex."""

  # ATTEMPT TO CAST IN A BQ QUERY
  client = bigquery.Client(project=project_id)
  sql = f"SELECT CAST('{value}' AS {data_type})"

  # If the query succeeds, return True
  try:
    job = client.query(sql)
    results = job.result()
    return True
  except Exception as e:
    return False
  
  '''
  # USING REGEX
  # This method is rigid, though could in theory be less rigid with fancier Regexing,
  # which would remove the need to run a BQ query to test data types...

  import re

  regex = r'^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{6}$'
  match = re.match(regex, value)

  if match:
    return True
  else:
    return False
  '''

def get_data_type(value,project_id):
  """
  Returns the data type of the input value (one of: "float", "timestamp", "string").
  These will be used to construct dbt models that cast values to the appropriate data types.
  """

  data_types_to_check = ["bigint","float","date","timestamp"]

  for data_type in data_types_to_check:
    if is_valid_bigquery_type(value, data_type, project_id):
      return data_type
  
  return "string"

def bq_table_to_dataframe(project_id,
                          dataset_id, 
                          table_id
                          ):
  """
  Params:

  project_id, dataset_id, table_id: builds the full reference for the table in BQ
  """

  # build the SQL for the query
  table_ref = f"{project_id}.{dataset_id}.{table_id}"
  sql = f"""SELECT * FROM `{table_ref}` LIMIT 1;"""
  
  # start the BQ client
  client = bigquery.Client(project=project_id)

  # run the job and fetch the results
  job = client.query(sql)
  results = job.result()

  # save results to a dataframe
  dataframe = results.to_dataframe()

  return dataframe

def get_field_names_and_datatypes(dataset_id,
                                  table_id,
                                  project_id):
  """
  Given an _airbyte_raw_* table, select one row of data, parse the JSON in _airbyte_data,
  and return a dict of {"field_name":"data_type"} mappings.
  """

  # read the first row of data and save to a pandas dataframe
  sample_df = bq_table_to_dataframe(dataset_id=dataset_id,
                                    table_id=f"_airbyte_raw_{table_id}",
                                    project_id=project_id)

  sample_data = json.loads(sample_df['_airbyte_data'][0])

  data_fields_and_types = {}

  for key, value in sample_data.items():
      field_name = key
      print(f"Determining data type for `{field_name}`...")
      data_type = get_data_type(value=value,
                                project_id=project_id)
      data_fields_and_types[field_name]=data_type
      if data_type[0] in 'aeiou':
        print(f"`{field_name}` will be cast as an {data_type}.") #yeah this is dumb but it was bothering me
      else:
        print(f"`{field_name}` will be cast as a {data_type}.")

  return data_fields_and_types