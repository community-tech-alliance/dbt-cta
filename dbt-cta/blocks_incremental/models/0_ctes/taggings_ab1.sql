{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'taggings') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    context,
    tag_id,
    created_at,
    tagger_type,
    id,
    phone_banking_question_id,
    taggable_id,
    tagger_id,
    taggable_type,
   {{ dbt_utils.surrogate_key([
     'context',
    'tag_id',
    'tagger_type',
    'id',
    'phone_banking_question_id',
    'taggable_id',
    'tagger_id',
    'taggable_type'
    ]) }} as _airbyte_taggings_hashid
from {{ source('cta', 'taggings') }}
