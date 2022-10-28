{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_source_redirect_ab3') }}
select
    _airbyte_source_hashid,
    url,
    status,
    return_url,
    failure_reason,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_redirect_hashid
from {{ ref('charges_source_redirect_ab3') }}
-- redirect at charges_base/source/redirect from {{ ref('charges_source') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

