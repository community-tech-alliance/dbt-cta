{{ config(
    unique_key = "tagResultId"
) }}

-- Final base SQL model
-- depends_on: {{ ref('tag_result_ab2') }}
select *
from {{ ref('tag_result_ab2') }}
