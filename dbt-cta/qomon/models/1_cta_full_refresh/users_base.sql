{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_ab2') }}
select *
from {{ ref('users_ab2') }}
