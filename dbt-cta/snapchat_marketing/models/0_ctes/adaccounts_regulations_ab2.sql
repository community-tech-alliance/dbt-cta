{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('adaccounts_regulations_ab1') }}
select
    ad_account_id,
    {{ cast_to_boolean('restricted_delivery_signals') }} as restricted_delivery_signals,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adaccounts_regulations_ab1') }}
-- regulations at adaccounts/regulations
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

