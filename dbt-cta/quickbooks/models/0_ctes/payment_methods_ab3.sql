{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_methods_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'SyncToken',
        'Type',
        boolean_to_string('Active'),
        boolean_to_string('sparse'),
        object_to_string('MetaData'),
        'domain',
        'airbyte_cursor',
        'Id',
        'Name',
    ]) }} as _airbyte_payment_methods_hashid,
    tmp.*
from {{ ref('payment_methods_ab2') }} as tmp
-- payment_methods
where 1 = 1
