{{ config(full_refresh=false) }}
select *
from {{ source('cta','taxes_tax_data_base') }}
