{{ config(full_refresh=false) }}
select *
from {{ source('cta','categories_category_data_base') }}
