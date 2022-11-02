{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('business_hours_business_hours_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_business_hours_hashid',
        object_to_string('friday'),
        object_to_string('monday'),
        object_to_string('sunday'),
        object_to_string('tuesday'),
        object_to_string('saturday'),
        object_to_string('thursday'),
        object_to_string('wednesday'),
    ]) }} as _airbyte_business_hours_2_hashid,
    tmp.*
from {{ ref('business_hours_business_hours_ab2') }} tmp
-- business_hours at business_hours/business_hours
where 1 = 1

