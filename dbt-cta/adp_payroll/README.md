# ADP Payroll

These dbt models do the following for ADP Payroll data (synced via Airflow from SFTP into BigQuery):

1. starting with _raw_payroll, generate an ephemeral model casting all the fields to appropriate datatypes. Note that for the fields that reflect dollar values, I took the liberty of chopping off the leading $  and converting them to floats, and appending _USD to the field names. This is how serious people store money-data in a database (so that they can be treated as numbers you know?)
2. update incremental model payroll_base (note that this means this dbt should run every day regardless of whether new data was ingested in the sync).
3. materialize payroll_base into a matview in the partner project called payroll that runs SELECT * from payroll_base.

There also exists a schema yaml to run a single dbt test that checks for not-null and unique on the _hashid field in payroll_base that was calculated by hashing the combo of all of the non-dollar-amount fields present in _raw_payroll.