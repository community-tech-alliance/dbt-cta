{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('creatives_web_view_properties_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_creatives_hashid',
        'url',
        boolean_to_string('block_preload'),
        array_to_string('deep_link_urls'),
        boolean_to_string('use_immersive_mode'),
        boolean_to_string('allow_snap_javascript_sdk'),
    ]) }} as _airbyte_web_view_properties_hashid,
    tmp.*
from {{ ref('creatives_web_view_properties_ab2') }} tmp
-- web_view_properties at creatives/web_view_properties
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

