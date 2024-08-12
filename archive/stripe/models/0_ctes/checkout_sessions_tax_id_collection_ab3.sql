{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_tax_id_collection_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_checkout_sessions_hashid',
        boolean_to_string('enabled'),
    ]) }} as _airbyte_tax_id_collection_hashid,
    tmp.*
from {{ ref('checkout_sessions_tax_id_collection_ab2') }} as tmp
-- tax_id_collection at checkout_sessions_base/tax_id_collection
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

