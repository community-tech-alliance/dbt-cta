{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('question_response_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'campaign_contact_id',
        'created_at',
        'id',
        'value',
        'interaction_step_id',
    ]) }} as _airbyte_question_response_hashid,
    tmp.*
from {{ ref('question_response_ab2') }} tmp
-- question_response
where 1 = 1


