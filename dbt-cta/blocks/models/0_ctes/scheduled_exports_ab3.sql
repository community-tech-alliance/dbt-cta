{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('scheduled_exports_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'day_of_the_week',
        boolean_to_string('paused'),
        'columns',
        'attachment_name',
        'format',
        'created_at',
        'uuid',
        'table_name',
        'frequency',
        'updated_at',
        'user_id',
        'time_zone_identifier',
        'recipients',
        'last_processed_at',
        'id',
        'hour_of_the_day',
    ]) }} as _airbyte_scheduled_exports_hashid,
    tmp.*
from {{ ref('scheduled_exports_ab2') }} tmp
-- scheduled_exports
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

