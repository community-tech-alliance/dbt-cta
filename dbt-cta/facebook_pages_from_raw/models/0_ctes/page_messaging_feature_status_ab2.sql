{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_messaging_feature_status_ab1') }}
select
    _airbyte_page_hashid,
    {{ cast_to_boolean('hop_v2') }} as hop_v2,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_messaging_feature_status_ab1') }}
-- messaging_feature_status at page/messaging_feature_status
where 1 = 1

