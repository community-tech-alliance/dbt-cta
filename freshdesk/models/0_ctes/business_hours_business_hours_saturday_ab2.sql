{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('business_hours_business_hours_saturday_ab1') }}
select
    _airbyte_business_hours_2_hashid,
    cast(end_time as {{ dbt_utils.type_string() }}) as end_time,
    cast(start_time as {{ dbt_utils.type_string() }}) as start_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('business_hours_business_hours_saturday_ab1') }}
-- saturday at business_hours/business_hours/saturday
where 1 = 1

