{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('conversations_ab2') }}
select *
from {{ ref('conversations_ab2') }}
