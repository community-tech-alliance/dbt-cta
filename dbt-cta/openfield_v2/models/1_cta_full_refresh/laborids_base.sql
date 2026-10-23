{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('laborids_ab2') }}
select *
from {{ ref('laborids_ab2') }}
