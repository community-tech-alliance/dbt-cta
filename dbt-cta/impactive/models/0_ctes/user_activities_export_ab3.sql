{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_activities_export_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'performs',
        'user_email',
        'utm_campaign',
        'user_last_name',
        'created_at',
        'testimonial_note',
        boolean_to_string('completed'),
        'impressions',
        'user_fullname',
        'user_last_seen_at',
        'exported_at',
        'user_first_name',
        'testimonial_media_url',
        'updated_at',
        'user_id',
        'activity_id',
        'clicks',
        'user_phone',
        'id',
        'published_at',
        'campaign_id',
        'utm_source',
        'activity_title',
    ]) }} as _airbyte_user_activities_export_hashid,
    tmp.*
from {{ ref('user_activities_export_ab2') }} tmp
-- user_activities_export
where 1 = 1

