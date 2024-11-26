{{ config(
    unique_key = "optOutId"
) }}

-- Final base SQL model
-- depends_on: {{ ref('optouts_ab1') }}
select *
from {{ ref('optouts_ab1') }}
