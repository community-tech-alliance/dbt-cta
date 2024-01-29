{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('activities_export_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'performs',
        'created_at',
        'completions',
        'description',
        'started',
        'folder_name',
        'impressions',
        'type',
        'title',
        'seen',
        'exported_at',
        'privacy_setting',
        'updated_at',
        'contact_list_id',
        'contact_list_name',
        'activity_id',
        'clicks',
        'id',
        'aasm_state',
        'folder_id',
        'published_at',
        'campaign_id',
    ]) }} as _airbyte_activities_export_hashid,
    tmp.*
from {{ ref('activities_export_ab2') }} tmp
-- activities_export
where 1 = 1

