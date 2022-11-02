{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('canned_responses_attachments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_canned_responses_hashid',
        'id',
        'name',
        'size',
        'thumb_url',
        'created_at',
        'updated_at',
        'content_type',
        'attachment_url',
    ]) }} as _airbyte_attachments_hashid,
    tmp.*
from {{ ref('canned_responses_attachments_ab2') }} tmp
-- attachments at canned_responses/attachments
where 1 = 1

