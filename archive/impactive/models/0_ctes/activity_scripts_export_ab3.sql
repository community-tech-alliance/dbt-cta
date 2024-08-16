{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('activity_scripts_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        'name',
        'activity_id',
        'created_at',
        'id',
        'script_type',
        'media_url',
        'script',
        'campaign_id',
        'exported_at',
        'next_scripts',
    ]) }} as _airbyte_activity_scripts_export_hashid,
    tmp.*
from {{ ref('activity_scripts_export_ab2') }} tmp
-- activity_scripts_export
where 1 = 1

