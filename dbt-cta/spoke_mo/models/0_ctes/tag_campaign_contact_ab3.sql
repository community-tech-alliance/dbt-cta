{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tag_campaign_contact_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'campaign_contact_id',
        'updated_at',
        'tag_id',
        'created_at',
        'id',
        'value',
    ]) }} as _airbyte_tag_campaign_contact_hashid,
    tmp.*
from {{ ref('tag_campaign_contact_ab2') }} tmp
-- tag_campaign_contact
where 1 = 1


