{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('actions_ab2') }}
select *
from {{ ref('actions_ab2') }}
