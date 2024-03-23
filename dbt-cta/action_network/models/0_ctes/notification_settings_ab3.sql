{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('notification_settings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'action_id',
        'created_at',
        'updated_at',
        'action_type',
        'third_parties_emails',
        'notificate_third_parties',
    ]) }} as _airbyte_notification_settings_hashid,
    tmp.*
from {{ ref('notification_settings_ab2') }} as tmp
-- notification_settings
where 1 = 1
