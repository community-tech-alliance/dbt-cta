{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vendors_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('CurrencyRef'),
        boolean_to_string('Vendor1099'),
        'FamilyName',
        'TaxIdentifier',
        'GivenName',
        'CompanyName',
        object_to_string('MetaData'),
        'DisplayName',
        object_to_string('PrimaryEmailAddr'),
        'AcctNum',
        object_to_string('WebAddr'),
        object_to_string('BillAddr'),
        object_to_string('PrimaryPhone'),
        'PrintOnCheckName',
        'airbyte_cursor',
        'Title',
        'MiddleName',
        object_to_string('Mobile'),
        'SyncToken',
        boolean_to_string('Active'),
        'Suffix',
        'domain',
        object_to_string('TermRef'),
        'Id',
        object_to_string('Fax'),
        'Balance',
    ]) }} as _airbyte_vendors_hashid,
    tmp.*
from {{ ref('vendors_ab2') }} tmp
-- vendors
where 1 = 1

