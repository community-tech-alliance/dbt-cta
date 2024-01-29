{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('accounts_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        object_to_string('CurrencyRef'),
        'airbyte_cursor',
        'CurrentBalance',
        'FullyQualifiedName',
        'AccountType',
        'Name',
        object_to_string('ParentRef'),
        'SyncToken',
        boolean_to_string('Active'),
        boolean_to_string('sparse'),
        object_to_string('MetaData'),
        'domain',
        'Classification',
        'CurrentBalanceWithSubAccounts',
        boolean_to_string('SubAccount'),
        'Id',
        'AcctNum',
        'AccountSubType',
    ]) }} as _airbyte_accounts_hashid,
    tmp.*
from {{ ref('accounts_ab2') }} tmp
-- accounts
where 1 = 1

