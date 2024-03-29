{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('offices_addresses_contacts_ab1') }}
select
    _airbyte_addresses_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(address_uri as {{ dbt_utils.type_string() }}) as address_uri,
    cast(official_uri as {{ dbt_utils.type_string() }}) as official_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('offices_addresses_contacts_ab1') }}
-- contacts at offices/addresses/contacts
where 1 = 1
