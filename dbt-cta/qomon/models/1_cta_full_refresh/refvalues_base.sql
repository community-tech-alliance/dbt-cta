{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('refvalues_ab2') }}
select *
from {{ ref('refvalues_ab2') }}
