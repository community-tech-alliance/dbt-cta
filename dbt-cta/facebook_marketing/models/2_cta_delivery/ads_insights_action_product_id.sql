select *
from {{ source('cta', 'ads_insights_action_product_id_base') }}
