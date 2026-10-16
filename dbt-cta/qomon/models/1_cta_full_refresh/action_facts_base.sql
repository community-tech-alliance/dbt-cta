{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('action_facts_ab2') }}
select *
from {{ ref('action_facts_ab2') }}
