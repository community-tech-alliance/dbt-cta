{{ config(
    unique_key = "tag_result_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('tag_result_ab2') }}
select *
from {{ ref('tag_result_ab2') }}
