{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('taxes_tax_data_ab3') }}
select
    _airbyte_taxes_hashid,
    name,
    enabled,
    percentage,
    tax_type_id,
    tax_type_name,
    inclusion_type,
    calculation_phase,
    applies_to_custom_amounts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tax_data_hashid
from {{ ref('taxes_tax_data_ab3') }}
-- tax_data at taxes/tax_data from {{ ref('taxes') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

