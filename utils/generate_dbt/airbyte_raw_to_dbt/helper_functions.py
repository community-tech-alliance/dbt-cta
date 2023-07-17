import json
import pandas as pd
from google.cloud import bigquery


def list_tables_in_bq_dataset(project_id, dataset_id):
    """
    Set up the BigQuery client and list all tables in the dataset
    """

    client = bigquery.Client(project=project_id)
    tables = list(client.list_tables(dataset_id))

    return tables


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

    """
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
  """


def get_data_type(value, project_id):
    """
    Returns the data type of the input value (one of: "float", "timestamp", "string").
    These will be used to construct dbt models that cast values to the appropriate data types.
    """

    data_types_to_check = ["bigint", "float", "date", "timestamp"]

    for data_type in data_types_to_check:
        if is_valid_bigquery_type(value, data_type, project_id):
            return data_type

    return "string"


def bq_table_to_dataframe(project_id, dataset_id, table_id):
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


def get_field_names_and_datatypes(dataset_id, table_id, project_id):
    """
    Given an _airbyte_raw_* table, select one row of data, parse the JSON in _airbyte_data,
    and return a dict of {"field_name":"data_type"} mappings.
    """

    print(f"Inferring data types for table `{table_id}`...")

    try:
        # read the first row of data and save to a pandas dataframe
        sample_df = bq_table_to_dataframe(
            dataset_id=dataset_id,
            table_id=f"_airbyte_raw_{table_id}",
            project_id=project_id,
        )
        sample_data = json.loads(sample_df["_airbyte_data"][0])
    except KeyError:
        print(f"No data in {table_id}.")
    else:
        data_fields_and_types = {}

        for key, value in sample_data.items():
            field_name = key
            data_type = get_data_type(value=value, project_id=project_id)
            data_fields_and_types[field_name] = data_type
            if data_type[0] in "aeiou":
                print(
                    f"`{field_name}` will be cast as an {data_type}."
                )  # yeah this is dumb but it was bothering me
            else:
                print(f"`{field_name}` will be cast as a {data_type}.")

        print(f"All done with data types for {table_id}.")

        return data_fields_and_types


def get_spec_dict_from_file(spec_json_path):
    """
    The main function uses this to turn the input json alchemy-like into a dict the script can use
    (The dict contains configs for all the tables in the sync - sync mode and unique keys)

    Params:
    spec_json_path (str): path (relative to the script being run) where the config json is located (eg, configs/blocks_tables.json)
    """

    # open the JSON file in read mode
    print(f"reading dict from {spec_json_path}")
    with open(spec_json_path, "r") as f:
        # load the contents of the file into a string
        spec_json_str = f.read()
        print(spec_json_str)
        # parse the JSON string into a list of dictionaries
        spec_json_dict = json.loads(spec_json_str)

    return spec_json_dict
