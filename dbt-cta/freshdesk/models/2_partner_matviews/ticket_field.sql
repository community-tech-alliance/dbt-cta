SELECT * FROM {{ source('cta', 'ticket_field_base') }}  _airbyte_emitted_at,
