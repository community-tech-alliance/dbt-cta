{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('usage_records_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
    'uri',
    'as_of',
    'count',
    'price',
    'usage',
    'category',
    'end_date',
    'count_unit',
    'price_unit',
    'start_date',
    'usage_unit',
    'account_sid',
    'api_version',
    'description',
    'subresource_uris'
    ]) }} as _airbyte_usage_records_hashid,
    tmp.*
from {{ ref('usage_records_ab2') }} as tmp
-- usage_records
where 1 = 1
