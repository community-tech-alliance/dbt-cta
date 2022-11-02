{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('business_hours_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'time_zone',
        'created_at',
        boolean_to_string('is_default'),
        'updated_at',
        'description',
        object_to_string('business_hours'),
    ]) }} as _airbyte_business_hours_hashid,
    tmp.*
from {{ ref('business_hours_ab2') }} tmp
-- business_hours
where 1 = 1

