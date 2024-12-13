select *
from {{ source('cta', 'ads_insights_demographics_dma_region_base') }}
