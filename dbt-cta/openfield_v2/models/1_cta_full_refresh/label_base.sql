{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('label_ab2') }}
select *
from {{ ref('label_ab2') }}
