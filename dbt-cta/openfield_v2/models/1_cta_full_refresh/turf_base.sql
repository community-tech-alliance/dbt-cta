{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('turf_ab2') }}
select *
from {{ ref('turf_ab2') }}
