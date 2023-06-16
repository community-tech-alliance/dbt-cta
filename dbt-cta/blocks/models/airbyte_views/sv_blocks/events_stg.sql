{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('events_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'notes',
        'extras',
        'created_at',
        'description',
        'type',
        'location_id',
        'event_type_id',
        boolean_to_string('public'),
        'updated_at',
        'turf_id',
        'public_page_header_data',
        'public_page_header_map_data',
        'id',
        'slug',
        'campaign_id',
        'invited_count',
        'no_show_count',
        'end_time',
        'public_settings',
        'created_by_user_id',
        'start_time',
        'first_occurrence_id',
        'organization_id',
        'name',
        'walk_in_count',
        'attended_count',
    ]) }} as _airbyte_events_hashid,
    tmp.*
from {{ ref('events_ab2') }} tmp
-- events
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

