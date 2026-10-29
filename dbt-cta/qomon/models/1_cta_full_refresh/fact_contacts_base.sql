{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('fact_contacts_ab2') }}
select *
from {{ ref('fact_contacts_ab2') }}
