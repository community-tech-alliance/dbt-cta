{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('CurrencyRef'),
        'FamilyName',
        'FullyQualifiedName',
        'GivenName',
        'CompanyName',
        object_to_string('ShipAddr'),
        object_to_string('MetaData'),
        object_to_string('PaymentMethodRef'),
        boolean_to_string('BillWithParent'),
        'DisplayName',
        'PreferredDeliveryMethod',
        'ResaleNum',
        boolean_to_string('Job'),
        object_to_string('PrimaryEmailAddr'),
        object_to_string('WebAddr'),
        object_to_string('BillAddr'),
        object_to_string('PrimaryPhone'),
        'PrintOnCheckName',
        'airbyte_cursor',
        'MiddleName',
        object_to_string('Mobile'),
        object_to_string('ParentRef'),
        'SyncToken',
        boolean_to_string('Active'),
        boolean_to_string('sparse'),
        'domain',
        'BalanceWithJobs',
        object_to_string('DefaultTaxCodeRef'),
        'Level',
        object_to_string('SalesTermRef'),
        'Id',
        object_to_string('Fax'),
        'Balance',
        boolean_to_string('Taxable'),
    ]) }} as _airbyte_customers_hashid,
    tmp.*
from {{ ref('customers_ab2') }} as tmp
-- customers
where 1 = 1
