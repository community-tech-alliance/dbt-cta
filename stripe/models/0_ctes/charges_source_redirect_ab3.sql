{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_source_redirect_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_source_hashid',
        'url',
        'status',
        'return_url',
        'failure_reason',
    ]) }} as _airbyte_redirect_hashid,
    tmp.*
from {{ ref('charges_source_redirect_ab2') }} tmp
-- redirect at charges/source/redirect
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

