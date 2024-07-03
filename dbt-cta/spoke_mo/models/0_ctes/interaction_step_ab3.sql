{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('interaction_step_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'answer_actions_data',
        boolean_to_string('is_deleted'),
        'question',
        'created_at',
        'answer_actions',
        'id',
        'answer_option',
        'parent_interaction_id',
        'script',
        'campaign_id',
    ]) }} as _airbyte_interaction_step_hashid,
    tmp.*
from {{ ref('interaction_step_ab2') }} tmp
-- interaction_step
where 1 = 1


