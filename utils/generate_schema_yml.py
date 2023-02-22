import os

import yaml

# As an example, these are the vars set for the mailchimp sync
DBT_VARS = os.getenv(
    "DBT_VARS",
    '{"campaigns_raw": "_airbyte_raw_campaigns", "campaigns_base": "campaigns_base", "campaigns": "campaigns"}',
)

TARGETS = ["cta", "partner"]


class LineBreakDumper(yaml.SafeDumper):
    """This is a custom yaml dumper class that adds some additional indents and line
    breaks"""

    def write_line_break(self, data=None):
        super().write_line_break(data)

        if len(self.indents) < 3:
            super().write_line_break()

    def increase_indent(self, flow=False, indentless=False):
        return super(LineBreakDumper, self).increase_indent(flow, False)


def list_model_directories(sync_name: str):
    """Given a sync name, list all the possible model directories"""
    base = f"{sync_name}/models"

    # Will need to tweak this if we nest models any further
    model_directories = [
        d for d in [base + "/" + b for b in os.listdir(base)] if os.path.isdir(d)
    ]

    return model_directories


def list_models(dir: str):
    """List all the models (sql files) in a directory, and return a list of model
    names"""
    files = os.listdir(dir)

    # trim the file extension off
    models = [f[:-4] for f in files if f.endswith(".sql")]

    return models


def get_model_config(model_name: str, target: str):
    """Run the dbt codegen generate_model_yaml for a given model and target, and return
    the model yaml parsed to a dictionary"""
    command = f"""dbt run-operation generate_model_yaml --args '{{"model_name": "{model_name}"}}' -t {target} --vars '{DBT_VARS}'"""

    stream = os.popen(command)
    output = stream.read()

    model_config = output.split("models:")[1]

    model_dict = yaml.load(model_config, Loader=yaml.Loader)

    return model_dict


def write_to_file(dict: dict, filename: str, overwrite: bool = False):
    """Given a dictionary, write it out as a yaml file, and optionally overwrite at
    the destination"""
    if os.path.exists(filename):
        if overwrite:
            print(f"{filename} already exists, overwriting(!).")
        else:
            print(f"{filename} already exists, not modifying.")

    with open(filename, "w") as file:
        yaml.dump(dict, file, sort_keys=False, Dumper=LineBreakDumper)
        print(f"YAML written to {filename}!")


def generate_filename(path, postfix=""):
    """Given a dbt model path, generate the schema.yml name, per dbt's best practices"""
    yaml_file_name = f'_{path.split("/")[-1]}__models{postfix}.yml'

    full_path = os.path.join(path, yaml_file_name)

    return full_path


def generate_schema_dict(directory_path):
    """Given a path to some dbt models, generate a dictionary for a schema.yml file
    for all models in the directory."""
    model_directory = directory_path.split("/")[-1]

    if model_directory == "0_ctes":
        print("Codegen doesn't work on emphemeral models, skipping.")
        return

    if model_directory[:1] in ["0", "1"]:
        target = "cta"
    elif model_directory[:1] in ["2", "3"]:
        target = "partner"
    else:
        target = None

    models = list_models(directory_path)

    model_configs = [get_model_config(m, target) for m in models]

    # TODO: Add test generation based on column name

    return {"version": 2, "models": [m[0] for m in model_configs]}


def main():
    dirs = list_model_directories("actblue")

    for d in dirs:
        schema_dict = generate_schema_dict(d)

        if schema_dict:
            out_file = generate_filename(d)

            write_to_file(schema_dict, out_file, overwrite=True)

        # TODO: load current schema.yml file and only add columns


if __name__ == "__main__":
    # TODO: add light CLI to control overwrite
    main()
