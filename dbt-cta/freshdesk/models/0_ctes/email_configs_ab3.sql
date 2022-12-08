{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_configs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        boolean_to_string('active'),
        'group_id',
        'to_email',
        'created_at',
        'product_id',
        'updated_at',
        'reply_email',
        boolean_to_string('primary_role'),
    ]) }} as _airbyte_email_configs_hashid,
    tmp.*
from {{ ref('email_configs_ab2') }} tmp
-- email_configs
where 1 = 1

