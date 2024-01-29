{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deliveries_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'city',
        'uuid',
        'email',
        'phone',
        'state',
        'status',
        'street',
        'country',
        'user_id',
        'tag_list',
        'zip_code',
        'form_data',
        'last_name',
        'letter_id',
        'created_at',
        'first_name',
        'updated_at',
        'display_name',
        'custom_fields',
        'message_to_target',
        'originating_system',
        'updates_from_creator',
        'updates_from_sponsor',
    ]) }} as _airbyte_deliveries_hashid,
    tmp.*
from {{ ref('deliveries_ab2') }} as tmp
-- deliveries
where 1 = 1
