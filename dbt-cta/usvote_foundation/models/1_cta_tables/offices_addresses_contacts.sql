{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "usvote_foundation",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('offices_addresses_contacts_ab3') }}
select
    _airbyte_addresses_hashid,
    id,
    address_uri,
    official_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_contacts_hashid
from {{ ref('offices_addresses_contacts_ab3') }}
-- contacts at offices/addresses/contacts from {{ ref('offices_addresses') }}
where 1 = 1

