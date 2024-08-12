{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('reports_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'user_email',
        'reportable_id',
        'reportable_voterbase_id',
        'created_at',
        'reportable_van_id',
        'user_fullname',
        'exported_at',
        'reportable_type',
        'reportable_phone',
        'updated_at',
        'user_id',
        'activity_id',
        'reportable_email',
        'taggings',
        'id',
        'campaign_id',
        'customizations',
        'reportable_fullname',
    ]) }} as _airbyte_reports_export_hashid,
    tmp.*
from {{ ref('reports_export_ab2') }} tmp
-- reports_export
where 1 = 1

