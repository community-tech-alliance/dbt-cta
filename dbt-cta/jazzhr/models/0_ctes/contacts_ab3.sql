{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('contacts_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
    ]) }} as _airbyte_contacts_hashid,
    tmp.*
from {{ ref('contacts_ab2') }} tmp
-- contacts
where 1 = 1

