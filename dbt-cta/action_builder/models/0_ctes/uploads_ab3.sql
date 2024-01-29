{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('uploads_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'key',
        'name',
        'bucket',
        'counts',
        'result',
        'status',
        'mappings',
        'created_at',
        'updated_at',
        'campaign_id',
        'upload_type',
        'created_by_id',
        'entity_type_id',
        'visibility_status',
        'processing_options',
        'identification_field',
    ]) }} as _airbyte_uploads_hashid,
    tmp.*
from {{ ref('uploads_ab2') }} as tmp
-- uploads
where 1 = 1
