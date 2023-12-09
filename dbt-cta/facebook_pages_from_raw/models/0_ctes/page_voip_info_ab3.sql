{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_voip_info_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        'reason_code',
        boolean_to_string('is_callable'),
        boolean_to_string('has_permission'),
        boolean_to_string('is_callable_webrtc'),
        boolean_to_string('is_pushable'),
        'reason_description',
        boolean_to_string('has_mobile_app'),
    ]) }} as _airbyte_voip_info_hashid,
    tmp.*
from {{ ref('page_voip_info_ab2') }} tmp
-- voip_info at page/voip_info
where 1 = 1

