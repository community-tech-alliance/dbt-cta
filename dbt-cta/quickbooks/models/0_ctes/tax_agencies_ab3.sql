{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tax_agencies_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'SyncToken',
        boolean_to_string('TaxTrackedOnPurchases'),
        boolean_to_string('sparse'),
        'TaxRegistrationNumber',
        object_to_string('MetaData'),
        'domain',
        'airbyte_cursor',
        'DisplayName',
        'Id',
        boolean_to_string('TaxTrackedOnSales'),
    ]) }} as _airbyte_tax_agencies_hashid,
    tmp.*
from {{ ref('tax_agencies_ab2') }} tmp
-- tax_agencies
where 1 = 1

