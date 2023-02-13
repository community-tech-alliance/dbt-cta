{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_social_card_ab1') }}
select
    _airbyte_campaigns_hashid,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(image_url as {{ dbt_utils.type_string() }}) as image_url,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_social_card_ab1') }}
-- social_card at campaigns/social_card
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

