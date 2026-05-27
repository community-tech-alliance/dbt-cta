{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('scripts_question_ab2') }}
select *
from {{ ref('scripts_question_ab2') }}
