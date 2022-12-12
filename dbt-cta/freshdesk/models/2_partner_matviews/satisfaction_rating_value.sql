-- Final Materialized View SQL model
-- depends_on: {{ ref('satisfaction_rating_base') }}
select
    id as satisfaction_rating_id,
    email
from {{ ref('satisfaction_rating_base') }} satisfaction_ratings, UNNEST(satisfaction_ratings.ratings) as rating
-- conversations from {{ source('cta', 'satisfaction_rating_base') }}


