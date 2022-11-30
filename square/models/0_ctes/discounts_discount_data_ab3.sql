{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('discounts_discount_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_discounts_hashid',
        'name',
        'percentage',
        object_to_string('amount_money'),
        boolean_to_string('pin_required'),
        'discount_type',
        'modify_tax_basis',
        'application_method',
    ]) }} as _airbyte_discount_data_hashid,
    tmp.*
from {{ ref('discounts_discount_data_ab2') }} tmp
-- discount_data at discounts/discount_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

