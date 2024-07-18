{{ config(
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('contacts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
    ]) }} as _airbyte_contacts_hashid,
    tmp.*
from {{ ref('contacts_ab2') }} tmp
-- contacts
where 1 = 1

