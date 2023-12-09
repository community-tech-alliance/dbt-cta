{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_messaging_feature_status_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        boolean_to_string('hop_v2'),
    ]) }} as _airbyte_messaging_feature_status_hashid,
    tmp.*
from {{ ref('page_messaging_feature_status_ab2') }} tmp
-- messaging_feature_status at page/messaging_feature_status
where 1 = 1

