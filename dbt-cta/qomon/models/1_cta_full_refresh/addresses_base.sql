{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('addresses_ab2') }}
select *
from {{ ref('addresses_ab2') }}
