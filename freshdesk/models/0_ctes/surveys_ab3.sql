{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('surveys_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'title',
        boolean_to_string('active'),
        array_to_string('questions'),
        'created_at',
        'updated_at',
    ]) }} as _airbyte_surveys_hashid,
    tmp.*
from {{ ref('surveys_ab2') }} tmp
-- surveys
where 1 = 1

