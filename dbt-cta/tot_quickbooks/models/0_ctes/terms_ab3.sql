{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('terms_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'DueNextMonthDays',
        'airbyte_cursor',
        'Name',
        'SyncToken',
        'Type',
        boolean_to_string('Active'),
        boolean_to_string('sparse'),
        'DueDays',
        object_to_string('MetaData'),
        'domain',
        'DiscountDayOfMonth',
        'Id',
        'DiscountDays',
        'DayOfMonthDue',
        'DiscountPercent',
    ]) }} as _airbyte_terms_hashid,
    tmp.*
from {{ ref('terms_ab2') }} tmp
-- terms
where 1 = 1

