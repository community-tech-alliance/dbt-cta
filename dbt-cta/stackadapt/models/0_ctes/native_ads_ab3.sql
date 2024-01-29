{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('native_ads_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        object_to_string('icon'),
        'name',
        'state',
        'channel',
        'cta_text',
        'brandname',
        'click_url',
        array_to_string('creatives'),
        'created_at',
        object_to_string('input_data'),
        'updated_at',
        'audit_status',
        array_to_string('vast_trackers'),
        array_to_string('api_frameworks'),
        array_to_string('imp_tracker_urls'),
    ]) }} as _airbyte_native_ads_hashid,
    tmp.*
from {{ ref('native_ads_ab2') }} as tmp
-- native_ads
where 1 = 1
