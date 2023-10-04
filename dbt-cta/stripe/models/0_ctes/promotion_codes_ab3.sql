{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('promotion_codes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'code',
        boolean_to_string('active'),
        object_to_string('coupon'),
        'object',
        'created',
        'customer',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        'expires_at',
        object_to_string('restrictions'),
        'max_redemptions',
    ]) }} as _airbyte_promotion_codes_hashid,
    tmp.*
from {{ ref('promotion_codes_ab2') }} as tmp
-- promotion_codes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

