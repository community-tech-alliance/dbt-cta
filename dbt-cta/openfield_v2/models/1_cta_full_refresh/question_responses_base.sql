{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('question_responses_ab2') }}
select *
from {{ ref('question_responses_ab2') }}
