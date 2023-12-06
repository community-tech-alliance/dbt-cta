{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_restaurant_services_ab1') }}
select
    _airbyte_page_hashid,
    {{ cast_to_boolean('outdoor') }} as outdoor,
    {{ cast_to_boolean('delivery') }} as delivery,
    {{ cast_to_boolean('reserve') }} as reserve,
    {{ cast_to_boolean('catering') }} as catering,
    {{ cast_to_boolean(adapter.quote('groups')) }} as {{ adapter.quote('groups') }},
    {{ cast_to_boolean('pickup') }} as pickup,
    {{ cast_to_boolean('walkins') }} as walkins,
    {{ cast_to_boolean('waiter') }} as waiter,
    {{ cast_to_boolean('takeout') }} as takeout,
    {{ cast_to_boolean('kids') }} as kids,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_restaurant_services_ab1') }}
-- restaurant_services at page/restaurant_services
where 1 = 1

