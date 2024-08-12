{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_activity_performances_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'performed_at',
        'user_email',
        'user_last_name',
        'user_fullname',
        'type',
        'exported_at',
        'user_first_name',
        'user_id',
        'activity_id',
        'user_phone',
        'id',
        'campaign_id',
        'activity_title',
    ]) }} as _airbyte_user_activity_performances_export_hashid,
    tmp.*
from {{ ref('user_activity_performances_export_ab2') }} tmp
-- user_activity_performances_export
where 1 = 1

