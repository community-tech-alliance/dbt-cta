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
    id,
    tag_id,
    context,
    tagger_id,
    created_at,
    taggable_id,
    tagger_type,
    taggable_type,
    phone_banking_question_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'tag_id',
    'context',
    'tagger_id',
    'taggable_id',
    'tagger_type',
    'taggable_type',
    'phone_banking_question_id'
    ]) }} as _airbyte_taggings_hashid
from {{ source('cta', 'taggings') }}
