
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'contacts_merged_audit') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   user_id,
   entity_id,
   last_name,
   timestamp,
   first_name,
   vid_to_merge,
   canonical_vid,
   merged_to_email,
   merged_from_email,
   num_properties_moved,
   merged_to_email_value,
   merged_from_email_value,
   merged_to_email_selected,
   merged_to_email_source_id,
   merged_to_email_timestamp,
   merged_from_email_selected,
   merged_from_email_source_id,
   merged_from_email_timestamp,
   merged_to_email_source_type,
   merged_to_email_source_label,
   merged_from_email_source_type,
   merged_from_email_source_vids,
   merged_from_email_source_label,
   merged_to_email_updated_by_user_id,
   merged_from_email_updated_by_user_id,
   {{ dbt_utils.surrogate_key([
     'user_id',
    'entity_id',
    'last_name',
    'timestamp',
    'first_name',
    'vid_to_merge',
    'canonical_vid',
    'num_properties_moved',
    'merged_to_email_value',
    'merged_from_email_value',
    'merged_to_email_selected',
    'merged_to_email_source_id',
    'merged_to_email_timestamp',
    'merged_from_email_selected',
    'merged_from_email_source_id',
    'merged_from_email_timestamp',
    'merged_to_email_source_type',
    'merged_to_email_source_label',
    'merged_from_email_source_type',
    'merged_from_email_source_label',
    'merged_to_email_updated_by_user_id',
    'merged_from_email_updated_by_user_id'
    ]) }} as _airbyte_contacts_merged_audit_hashid
from {{ source('cta', 'contacts_merged_audit') }}