
SELECT
    *
FROM  {{ source('cta', 'entity_sync_states_base') }}