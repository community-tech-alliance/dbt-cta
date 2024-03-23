{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_tests_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'hours',
        adapter.quote('limit'),
        'params',
        'auto_win',
        'email_id',
        'statistic',
        'threshold',
        'created_at',
        'updated_at',
        'winning_email_id',
    ]) }} as _airbyte_email_tests_hashid,
    tmp.*
from {{ ref('email_tests_ab2') }} as tmp
-- email_tests
where 1 = 1
