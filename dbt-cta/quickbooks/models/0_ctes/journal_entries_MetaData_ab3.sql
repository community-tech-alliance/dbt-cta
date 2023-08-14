{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('journal_entries_MetaData_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_journal_entries_hashid',
        'CreateTime',
        'LastUpdatedTime',
    ]) }} as _airbyte_MetaData_hashid,
    tmp.*
from {{ ref('journal_entries_MetaData_ab2') }} tmp
-- MetaData at journal_entries/MetaData
where 1 = 1

