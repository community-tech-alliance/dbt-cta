{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('public_event_links_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'event_id',
        'user_id',
        'id',
        'url',
    ]) }} as _airbyte_public_event_links_hashid,
    tmp.*
from {{ ref('public_event_links_ab2') }} tmp
-- public_event_links
where 1 = 1

