{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('profiles_ab2') }}
select *
from {{ ref('profiles_ab2') }}
