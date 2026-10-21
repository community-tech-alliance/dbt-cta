{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('forms_ab2') }}
select *
from {{ ref('forms_ab2') }}
