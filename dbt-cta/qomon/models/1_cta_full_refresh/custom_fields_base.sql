{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('custom_fields_ab2') }}
select *
from {{ ref('custom_fields_ab2') }}
