{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('items_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'Description',
        'QtyOnHand',
        'airbyte_cursor',
        'FullyQualifiedName',
        'PurchaseDesc',
        boolean_to_string('TrackQtyOnHand'),
        object_to_string('AssetAccountRef'),
        object_to_string('IncomeAccountRef'),
        'Name',
        'SyncToken',
        'Type',
        boolean_to_string('Active'),
        'UnitPrice',
        object_to_string('ExpenseAccountRef'),
        boolean_to_string('sparse'),
        object_to_string('MetaData'),
        'PurchaseCost',
        'domain',
        'InvStartDate',
        'Id',
        boolean_to_string('Taxable'),
    ]) }} as _airbyte_items_hashid,
    tmp.*
from {{ ref('items_ab2') }} as tmp
-- items
where 1 = 1
