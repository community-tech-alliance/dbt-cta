{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_preferences_ab1') }}
select
    _airbyte_customers_hashid,
    {{ cast_to_boolean('email_unsubscribed') }} as email_unsubscribed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_preferences_ab1') }}
-- preferences at customers/preferences
where 1 = 1
