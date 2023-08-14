{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tax_rates_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('AgencyRef'),
        'RateValue',
        'Description',
        'DisplayType',
        'airbyte_cursor',
        'Name',
        'SpecialTaxType',
        'SyncToken',
        'EffectiveTaxRate',
        boolean_to_string('Active'),
        boolean_to_string('sparse'),
        object_to_string('MetaData'),
        'domain',
        'Id',
    ]) }} as _airbyte_tax_rates_hashid,
    tmp.*
from {{ ref('tax_rates_ab2') }} tmp
-- tax_rates
where 1 = 1

