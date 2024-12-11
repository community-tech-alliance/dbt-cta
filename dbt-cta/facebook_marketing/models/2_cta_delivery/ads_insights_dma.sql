select *
from {{ source('cta', 'ads_insights_dma_base') }}
