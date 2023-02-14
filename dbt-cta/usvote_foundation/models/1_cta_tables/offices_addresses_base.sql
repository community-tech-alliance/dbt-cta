{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "usvote_foundation",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('offices_addresses_ab3') }}
select
    _airbyte_offices_hashid,
    id,
    zip,
    city,
    zip4,
    state,
    street1,
    street2,
    website,
    contacts,
    functions,
    address_to,
    main_email,
    is_physical,
    resource_uri,
    is_regular_mail,
    main_fax_number,
    main_phone_number,
    primary_contact_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_addresses_hashid
from {{ ref('offices_addresses_ab3') }}
-- addresses at offices/addresses from {{ ref('offices') }}
where 1 = 1
