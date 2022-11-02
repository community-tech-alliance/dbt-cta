{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('canned_responses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'title',
        'content',
        'folder_id',
        'created_at',
        'updated_at',
        array_to_string('attachments'),
        'content_html',
    ]) }} as _airbyte_canned_responses_hashid,
    tmp.*
from {{ ref('canned_responses_ab2') }} tmp
-- canned_responses
where 1 = 1

