{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('event_campaign_uploads_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        adapter.quote('rows'),
        'failure',
        'user_id',
        'created_at',
        'updated_at',
        'upload_type',
        'fail_message',
        'csv_file_name',
        'csv_file_size',
        'csv_content_type',
        'event_campaign_id',
    ]) }} as _airbyte_event_campaign_uploads_hashid,
    tmp.*
from {{ ref('event_campaign_uploads_ab2') }} tmp
-- event_campaign_uploads
where 1 = 1

