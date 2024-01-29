{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('available_phone_number_countries_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'uri',
        boolean_to_string('beta'),
        'country',
        'country_code',
        object_to_string('subresource_uris'),
    ]) }} as _airbyte_available_phone_number_countries_hashid,
    tmp.*
from {{ ref('available_phone_number_countries_ab2') }} as tmp
-- available_phone_number_countries
where 1 = 1
