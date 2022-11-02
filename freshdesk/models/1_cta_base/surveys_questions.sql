{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('surveys_questions_ab3') }}
select
    _airbyte_surveys_hashid,
    id,
    label,
    {{ adapter.quote('default') }},
    accepted_ratings,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_questions_hashid
from {{ ref('surveys_questions_ab3') }}
-- questions at surveys/questions from {{ ref('surveys') }}
where 1 = 1

