{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('interaction_step_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'question',
        'created_at',
        boolean_to_string('is_deleted'),
        'updated_at',
        'campaign_id',
        'answer_option',
        'answer_actions',
        array_to_string('script_options'),
        'parent_interaction_id',
    ]) }} as _airbyte_interaction_step_hashid,
    tmp.*
from {{ ref('interaction_step_ab2') }} tmp
-- interaction_step
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

