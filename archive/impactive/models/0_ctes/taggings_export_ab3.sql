{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('taggings_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'reportable_id',
        'voterbase_id',
        'reported_by_email',
        'tag_name',
        'tag_slug',
        'created_at',
        'exported_at',
        'reportable_type',
        'van_id',
        'updated_at',
        'phone',
        'user_id',
        'tag_id',
        'id',
        'fullname',
        'taggable_id',
        'reported_by_fullname',
        boolean_to_string('value'),
        'email',
        'campaign_id',
        'taggable_type',
    ]) }} as _airbyte_taggings_export_hashid,
    tmp.*
from {{ ref('taggings_export_ab2') }} tmp
-- taggings_export
where 1 = 1

