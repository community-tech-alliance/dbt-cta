{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('taxes_tax_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_taxes_hashid',
        'name',
        boolean_to_string('enabled'),
        'percentage',
        'tax_type_id',
        'tax_type_name',
        'inclusion_type',
        'calculation_phase',
        boolean_to_string('applies_to_custom_amounts'),
    ]) }} as _airbyte_tax_data_hashid,
    tmp.*
from {{ ref('taxes_tax_data_ab2') }} tmp
-- tax_data at taxes/tax_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

