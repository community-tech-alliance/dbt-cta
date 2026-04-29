{{ config(
    materialized="table"
) }}
{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_ab2') }}
select *
from {{ ref('campaigns_ab2') }}
