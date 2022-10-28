{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_ab3') }}
select
    id,
    url,
    name,
    type,
    active,
    images,
    object,
    caption,
    created,
    updated,
    livemode,
    metadata,
    shippable,
    attributes,
    unit_label,
    description,
    deactivate_on,
    package_dimensions,
    statement_descriptor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_products_hashid
from {{ ref('products_ab3') }}
-- products from {{ source('stripe_partner_a', '_airbyte_raw_products') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

