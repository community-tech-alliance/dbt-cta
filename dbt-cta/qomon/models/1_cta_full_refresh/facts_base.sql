{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('facts_ab2') }}
select *
from {{ ref('facts_ab2') }}
