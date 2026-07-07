{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('people_ab2') }}
select *
from {{ ref('people_ab2') }}
