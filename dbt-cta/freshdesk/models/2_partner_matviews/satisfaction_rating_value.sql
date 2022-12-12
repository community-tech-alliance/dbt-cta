-- Final Materialized View SQL model
-- depends_on: {{ ref('satisfaction_rating_base') }}
select
    id as satisfaction_rating_id,
    ratings
from {{ source('cta', 'satisfaction_rating_base') }}
-- conversations from {{ source('cta', 'satisfaction_rating_base') }}


