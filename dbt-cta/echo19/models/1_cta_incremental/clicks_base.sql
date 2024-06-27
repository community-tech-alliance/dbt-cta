{{ config(
    unique_key = "clicks_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('clicks_ab2') }}
select
*
from {{ ref('clicks_ab2') }} as t
