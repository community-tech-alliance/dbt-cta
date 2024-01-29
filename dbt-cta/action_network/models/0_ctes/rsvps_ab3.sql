{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('rsvps_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'city',
        'uuid',
        'email',
        'phone',
        'street',
        'country',
        'user_id',
        'event_id',
        'tag_list',
        'zip_code',
        'last_name',
        'created_at',
        'first_name',
        'updated_at',
        'guest_count',
        'display_name',
        'custom_fields',
        'message_to_target',
        'originating_system',
        'updates_from_creator',
        'updates_from_sponsor',
    ]) }} as _airbyte_rsvps_hashid,
    tmp.*
from {{ ref('rsvps_ab2') }} as tmp
-- rsvps
where 1 = 1
