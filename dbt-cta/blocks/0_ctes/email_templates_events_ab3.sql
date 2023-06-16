{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_templates_events_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'event_id',
        'updated_at',
        'email_template_id',
        'created_at',
    ]) }} as _airbyte_email_templates_events_hashid,
    tmp.*
from {{ ref('email_templates_events_ab2') }} tmp
-- email_templates_events
where 1 = 1

