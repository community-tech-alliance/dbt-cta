{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'events_campaign') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   id,
   name,
   title,
   hidden,
   show_zip,
   timezone,
   show_city,
   starts_at,
   use_title,
   created_at,
   mode_local,
   show_notes,
   show_state,
   show_title,
   show_venue,
   updated_at,
   mode_global,
   mode_onsite,
   allow_private,
   default_title,
   show_address1,
   max_event_size,
   use_start_date,
   use_start_time,
   show_directions,
   allow_moderation,
   show_full_events,
   default_event_size,
   public_create_page,
   public_search_page,
   show_attendee_count,
   allow_moderator_edits,
   show_completed_events,
   require_staff_approval,
   show_public_description,
   require_email_confirmation
from {{ source('cta', 'events_campaign') }}
