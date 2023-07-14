import os
import create_dbt_files as create_dbt
import helper_functions as helper

# Constants
project_id='dev3869c056'
dataset_id='flambe'
sync_dir = "science"
models_dir = "models"
model_types = ["0_ctes","1_cta_full_refresh","1_cta_incremental","2_partner_matviews"]

# TODO rewrite this to grab from BQ rather than hardcoding
# In cases where we need to add _airbyte_raw_* or *_base (etc),
# that happens in the function that does the thing,
# rather than passing in different flavors of table_id.
table_ids = ['friendly_id_slugs','admin_users']

# Setup
# Create some folders for the dbt files to be written to
for model_type in model_types:
    new_path = os.path.join(sync_dir,
                        models_dir,
                        model_type
                        )
    os.makedirs(new_path, exist_ok=True)

path_to_models_folder = os.path.join(sync_dir,
                        models_dir)

path_to_ctes_folder = os.path.join(sync_dir,
                        models_dir,
                        "0_ctes"
                        )


##########################
## Generate sources.yml ##
##########################

print(f"writing sources.yaml to {path_to_models_folder}")
create_dbt.create_sources_yaml(tables_list=table_ids,
                    path_to_models_folder=path_to_models_folder)

####
### THE REST OF THIS ITERATES THROUGH EACH TABLE
#### but for now we'll just do it with one
table_id=table_ids[0]

##############################
## Generate the model files ##
##############################
# Setup: get field names and data types for the table
# data_fields_and_types = helper.get_field_names_and_datatypes(project_id=project_id,dataset_id=dataset_id,table_id=table_id)
# Or use this to test:
data_fields_and_types = {'sluggable_type': 'string', 'sluggable_id': 'bigint', 'scope': 'string', 'created_at': 'timestamp', 'id': 'bigint', 'slug': 'string'}

create_dbt.write_all_cte_models(table_id=table_id,
                        data_fields_and_types=data_fields_and_types,
                        path_to_models_folder=path_to_models_folder)