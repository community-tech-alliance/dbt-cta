select *
from {{ source('cta','categories_category_data_base') }}
