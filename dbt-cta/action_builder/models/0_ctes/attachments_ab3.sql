{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('attachments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'size',
        'artifact',
        'mime_type',
        'created_at',
        'updated_at',
        'attachable_id',
        'created_by_id',
        'attachable_type',
    ]) }} as _airbyte_attachments_hashid,
    tmp.*
from {{ ref('attachments_ab2') }} tmp
-- attachments
where 1 = 1

