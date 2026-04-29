{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('question_dropdown_options_ab2') }}
select *
from {{ ref('question_dropdown_options_ab2') }}
