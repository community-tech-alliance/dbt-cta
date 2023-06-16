{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('delivery_forms_exclusions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'voter_registration_scan_id',
        'delivery_id',
    ]) }} as _airbyte_delivery_forms_exclusions_hashid,
    tmp.*
from {{ ref('delivery_forms_exclusions_ab2') }} tmp
-- delivery_forms_exclusions
where 1 = 1

