{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('scripts_ab2') }}
select *
from {{ ref('scripts_ab2') }}
