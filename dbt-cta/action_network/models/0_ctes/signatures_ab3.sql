{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('signatures_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'city',
        'uuid',
        'email',
        'phone',
        'street',
        'country',
        'user_id',
        'tag_list',
        'zip_code',
        'last_name',
        'created_at',
        'first_name',
        'updated_at',
        'petition_id',
        'display_name',
        'custom_fields',
        'message_to_target',
        'originating_system',
        'updates_from_creator',
        'updates_from_sponsor',
    ]) }} as _airbyte_signatures_hashid,
    tmp.*
from {{ ref('signatures_ab2') }} as tmp
-- signatures
where 1 = 1
