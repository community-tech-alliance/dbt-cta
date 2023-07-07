{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tag_canned_response_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'canned_response_id',
        'tag_id',
        'created_at',
        'id',
    ]) }} as _airbyte_tag_canned_response_hashid,
    tmp.*
from {{ ref('tag_canned_response_ab2') }} tmp
-- tag_canned_response
where 1 = 1


