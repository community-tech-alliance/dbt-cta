{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('locations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'mcc',
        'name',
        'type',
        'status',
        object_to_string('address'),
        'country',
        'currency',
        'timezone',
        'created_at',
        'description',
        'merchant_id',
        'website_url',
        array_to_string('capabilities'),
        'facebook_url',
        'phone_number',
        'business_name',
        'language_code',
        'business_email',
        object_to_string('business_hours'),
        'twitter_username',
        'instagram_username',
    ]) }} as _airbyte_locations_hashid,
    tmp.*
from {{ ref('locations_ab2') }} tmp
-- locations
where 1 = 1

