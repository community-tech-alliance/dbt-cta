{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('business_hours_business_hours_ab1') }}
select
    _airbyte_business_hours_hashid,
    cast(friday as {{ type_json() }}) as friday,
    cast(monday as {{ type_json() }}) as monday,
    cast(sunday as {{ type_json() }}) as sunday,
    cast(tuesday as {{ type_json() }}) as tuesday,
    cast(saturday as {{ type_json() }}) as saturday,
    cast(thursday as {{ type_json() }}) as thursday,
    cast(wednesday as {{ type_json() }}) as wednesday,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('business_hours_business_hours_ab1') }}
-- business_hours at business_hours/business_hours
where 1 = 1

