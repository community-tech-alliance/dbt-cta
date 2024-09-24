{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tax_codes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'Description',
        object_to_string('PurchaseTaxRateList'),
        'airbyte_cursor',
        object_to_string('SalesTaxRateList'),
        'Name',
        'SyncToken',
        boolean_to_string('Active'),
        boolean_to_string('sparse'),
        object_to_string('MetaData'),
        boolean_to_string('TaxGroup'),
        'domain',
        boolean_to_string('Hidden'),
        'Id',
        boolean_to_string('Taxable'),
    ]) }} as _airbyte_tax_codes_hashid,
    tmp.*
from {{ ref('tax_codes_ab2') }} as tmp
-- tax_codes
where 1 = 1
