{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('business_hours_business_hours_wednesday_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_business_hours_2_hashid',
        'end_time',
        'start_time',
    ]) }} as _airbyte_wednesday_hashid,
    tmp.*
from {{ ref('business_hours_business_hours_wednesday_ab2') }} tmp
-- wednesday at business_hours/business_hours/wednesday
where 1 = 1

