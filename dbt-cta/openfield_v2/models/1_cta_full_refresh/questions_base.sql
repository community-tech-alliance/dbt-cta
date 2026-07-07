{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('questions_ab2') }}
select *
from {{ ref('questions_ab2') }}
