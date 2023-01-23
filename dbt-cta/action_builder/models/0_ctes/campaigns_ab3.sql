{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'status',
        'created_at',
        'updated_at',
        'interact_id',
        'created_by_id',
        'target_number',
        'default_country',
        boolean_to_string('show_custom_ids'),
        'support_user_id',
        'toplines_settings',
        'default_entity_type_id',
        boolean_to_string('show_electoral_districts'),
        boolean_to_string('allow_organizers_to_export'),
        'restricted_exporting_settings',
        boolean_to_string('activity_stream_as_initial_entity_view'),
    ]) }} as _airbyte_campaigns_hashid,
    tmp.*
from {{ ref('campaigns_ab2') }} tmp
-- campaigns
where 1 = 1

