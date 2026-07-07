{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('conversation_code_ab2') }}
select *
from {{ ref('conversation_code_ab2') }}
