{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('customuser_ab2') }}
select *
from {{ ref('customuser_ab2') }}
