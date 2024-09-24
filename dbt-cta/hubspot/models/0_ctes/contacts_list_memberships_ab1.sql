{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'contacts_list_memberships') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    vid,
    is_member,
    timestamp,
    canonical_vid,
    static_list_id,
    internal_list_id,
   {{ dbt_utils.surrogate_key([
     'vid',
    'is_member',
    'timestamp',
    'canonical_vid',
    'static_list_id',
    'internal_list_id'
    ]) }} as _airbyte_contacts_list_memberships_hashid
from {{ source('cta', 'contacts_list_memberships') }}
